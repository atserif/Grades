//
//  GPAView.swift
//  Grades
//
//  Created by Aram Soneson on 1/20/26.
//

import SwiftUI

struct GPAView: View {
	@Environment(\.horizontalSizeClass) private var horizontalSizeClass
	@Environment(\.editMode) private var editMode

	@State private var selection: Set<UUID> = []
	@State private var editState: EditMode = .inactive
	@State private var initialCourses: [Course] = (1...7).map { _ in
		Course(name: "New Course", grade: .A, level: .regular)
	}
	@State private var courses: [Course] = (1...7).map { _ in
		Course(name: "New Course", grade: .A, level: .regular)
	}
	
	private var unweightedGPA: Double {
		let total: Double = courses.map { $0.grade.rawValue }.reduce(0, +)
		return total / Double(courses.count)
	}
	private var weightedGPA: Double {
		let total = courses.map { $0.grade.rawValue + $0.level.rawValue }.reduce(0, +)
		return total / Double(courses.count)
	}
	private var navigationTitle: String {
		switch horizontalSizeClass {
		case .regular:
			"Grade Point Average"
		case .compact, .none, .some:
			"GPA"
		}
	}
	
	var body: some View {
		NavigationStack {
			if courses.isEmpty {
				ContentUnavailableView("No Courses", systemImage: "graduationcap", description: Text("Your courses will appear here."))
					.navigationTitle(navigationTitle)
					.toolbarTitleDisplayMode(.inlineLarge)
					#if os(iOS)
					.background(Color(.systemGroupedBackground))
					#endif
					.toolbar {
						ToolbarItemGroup(placement: .topBarTrailing) {
//							Menu("More", systemImage: "ellipsis") {
								Button("New Course", systemImage: "plus") {
									withAnimation {
										let newCourse = Course(name: "New Course", grade: .A, level: .regular)
										courses.append(newCourse)
									}
								}
								.disabled(courses.count >= 50)
								
								Button("Reset", systemImage: "arrow.clockwise") {
									withAnimation {
										courses = initialCourses
									}
								}
								.disabled(courses.elementsEqual(initialCourses) { $0.name == $1.name && $0.grade == $1.grade && $0.level == $1.level })
//							}
						}
					}
			} else {
				List(selection: $selection) {
					switch horizontalSizeClass {
					case .regular:
						RegularGPAContent(courses: $courses, unweightedGPA: unweightedGPA, weightedGPA: weightedGPA)
					case .compact, .none, .some:
						CompactGPAContent(courses: $courses, unweightedGPA: unweightedGPA, weightedGPA: weightedGPA)
					}
				}
				.formStyle(.grouped)
				.navigationTitle(navigationTitle)
				.toolbarTitleDisplayMode(.inlineLarge)
				.scrollDismissesKeyboard(.interactively)
				.animation(.default, value: editState)
				.animation(.default, value: selection)
				.environment(\.editMode, $editState)
				.toolbarVisibility(editState == .inactive ? .automatic : .hidden, for: .tabBar)
				.toolbarVisibility(editState == .inactive ? .hidden : .automatic, for: .bottomBar)
				.toolbar {
					if editState == .inactive {
						ToolbarItem(placement: .topBarTrailing) {
							Button("Select") {
								withAnimation {
									editState = .active
								}
							}
						}
						
						ToolbarSpacer(.fixed, placement: .topBarTrailing)
						
						ToolbarItemGroup(placement: .topBarTrailing) {
//							Menu("More", systemImage: "ellipsis") {
								Button("New Course", systemImage: "plus") {
									withAnimation {
										let newCourse = Course(name: "New Course", grade: .A, level: .regular)
										courses.append(newCourse)
									}
								}
								.disabled(courses.count >= 50)
								
								Button("Reset", systemImage: "arrow.clockwise") {
									withAnimation {
										courses = initialCourses
									}
								}
								.disabled(courses.elementsEqual(initialCourses) { $0.name == $1.name && $0.grade == $1.grade && $0.level == $1.level })
//							}
						}
					} else {
						if selection.count == courses.count {
							ToolbarItem(placement: .topBarTrailing) {
								Button("Deselect All") {
									withAnimation {
										selection.removeAll()
									}
								}
							}
						} else {
							ToolbarItem(placement: .topBarTrailing) {
								Button("Select All") {
									withAnimation {
										selection = Set(courses.map { $0.id })
									}
								}
							}
						}
						
						ToolbarItem(placement: .confirmationAction) {
							Button("Confirm", systemImage: "checkmark", role: .confirm) {
								withAnimation {
									editState = .inactive
									selection.removeAll()
								}
							}
						}
					}
					
					ToolbarSpacer(.flexible, placement: .bottomBar)
					
					ToolbarItem(placement: .bottomBar) {
						Button("Delete", systemImage: "trash", role: .destructive) {
							withAnimation {
								courses.removeAll { course in
									selection.contains(course.id)
								}
								
								selection.removeAll()
								
								if courses.isEmpty {
									editState = .inactive
								}
							}
						}
						.disabled(selection.count <= 0)
					}
				}
			}
		}
	}
}

#Preview {
	ContentView()
}
