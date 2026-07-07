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
	
	private func resetCourses() {
		courses = (1...7).map { _ in
			Course(name: "New Course", grade: .A, level: .regular)
		}
	}
	
	var body: some View {
		NavigationStack {
			List(selection: $selection) {
				if !courses.isEmpty {
					switch horizontalSizeClass {
					case .regular:
						RegularGPAContent(editState: $editState, courses: $courses, unweightedGPA: unweightedGPA, weightedGPA: weightedGPA)
					case .compact, .none, .some:
						CompactGPAContent(editState: $editState, courses: $courses, unweightedGPA: unweightedGPA, weightedGPA: weightedGPA)
					}
				}
			}
			.listStyle(.insetGrouped)
			.navigationTitle(navigationTitle)
			.toolbarTitleDisplayMode(.inlineLarge)
			.scrollDismissesKeyboard(.interactively)
			.environment(\.editMode, $editState)
			.toolbarVisibility(editState == .inactive ? .automatic : .hidden, for: .tabBar)
			.toolbarVisibility(editState == .inactive ? .hidden : .automatic, for: .bottomBar)
			.overlay {
				if courses.isEmpty {
					ContentUnavailableView {
						Label("No Courses", systemImage: "graduationcap.fill")
					} description: {
						Text("Courses you add will appear here.")
					}
					.background(Color(.systemGroupedBackground))
				}
			}
			.toolbar {
				if editState == .inactive {
					ToolbarItem(placement: .topBarTrailing) {
						Button("Select") {
							withAnimation {
								selection.removeAll()
								editState = .active
							}
						}
						.disabled(courses.isEmpty)
					}
					
					ToolbarSpacer(.fixed, placement: .topBarTrailing)
					
					ToolbarItemGroup(placement: .primaryAction) {
//						Menu("More", systemImage: "ellipsis") {
							Button("New Course", systemImage: "plus") {
								withAnimation {
									let newCourse = Course(name: "New Course", grade: .A, level: .regular)
									courses.append(newCourse)
								}
							}
							.disabled(courses.count >= 50)
							
							Button("Reset", systemImage: "arrow.clockwise") {
								withAnimation {
									resetCourses()
								}
							}
//						}
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
				
				ToolbarItem(placement: .bottomBar) {
					Button("Reset", systemImage: "arrow.clockwise") {
						withAnimation {
							resetCourses()
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

#Preview {
	ContentView()
}
