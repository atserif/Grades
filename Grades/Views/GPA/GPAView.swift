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

	@State private var editState: EditMode = .inactive
	@State private var selection: Set<UUID> = []
	@State private var courses: [Course] = []
	
	@FocusState private var focused: UUID?
	
	private var unweightedGPA: Double {
		let total: Double = courses.map { $0.grade.rawValue }.reduce(0, +)
		return total / Double(courses.count)
	}
	private var weightedGPA: Double {
		let total = courses.map { $0.grade.rawValue + $0.level.rawValue }.reduce(0, +)
		return total / Double(courses.count)
	}
	private var navigationTitle: LocalizedStringKey {
		switch horizontalSizeClass {
		case .regular:
			"Grade Point Average"
		case .compact, .none, .some:
			"GPA"
		}
	}
	private var allCoursesSelected: Bool {
		if selection.count == courses.count {
			true
		} else {
			false
		}
	}
	
	private func newCourse(scrollReaderProxy: ScrollViewProxy) {
		let newCourse = Course(name: "", grade: .A, level: .regular)
		courses.append(newCourse)
		
		DispatchQueue.main.async {
			withAnimation {
				scrollReaderProxy.scrollTo(newCourse.id, anchor: .top)
				
				focused = newCourse.id
			}
		}
	}
	
	var body: some View {
		NavigationStack {
			ScrollViewReader { proxy in
				List(selection: $selection) {
					if !courses.isEmpty {
						GPAContent(editState: $editState, courses: $courses, focused: $focused, unweightedGPA: unweightedGPA, weightedGPA: weightedGPA)
					}
				}
				.listStyle(.insetGrouped)
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
					ToolbarItem(placement: .title) {
						StaticNavigationTitle(title: navigationTitle)
					}
					
					if editState == .inactive {
						ToolbarItem(placement: .topBarTrailing) {
							Button("Select") {
								withAnimation {
									editState = .active
								}
							}
							.disabled(courses.isEmpty)
						}
						
						ToolbarSpacer(.fixed, placement: .topBarTrailing)
						
						ToolbarItemGroup(placement: .primaryAction) {
							Button("New Course", systemImage: "plus") {
								withAnimation {
									newCourse(scrollReaderProxy: proxy)
								}
							}
							.disabled(courses.count >= 20)
							
							Button("Reset", systemImage: "arrow.clockwise") {
								withAnimation {
									courses.removeAll()
								}
							}
						}
					} else {
						if allCoursesSelected {
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
								}
							}
						}
					}
					
					ToolbarItem(placement: .bottomBar) {
						Button("Reset", systemImage: "arrow.clockwise") {
							withAnimation {
								for index in courses.indices where selection.contains(courses[index].id) {
									courses[index].name = ""
									courses[index].grade = .A
									courses[index].level = .regular
								}
							}
						}
						.disabled(selection.isEmpty)
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
						.disabled(selection.isEmpty)
					}
				}
				.toolbarVisibility(editState == .inactive ? .automatic : .hidden, for: .tabBar)
				.toolbarVisibility(editState == .inactive ? .hidden : .automatic, for: .bottomBar)
				.toolbarTitleDisplayMode(.inline)
				.toolbarRole(.editor)
				.scrollDismissesKeyboard(.immediately)
				.animation(.default, value: allCoursesSelected)
				.environment(\.editMode, $editState)
			}
		}
	}
}

#Preview {
	GPAView()
}
