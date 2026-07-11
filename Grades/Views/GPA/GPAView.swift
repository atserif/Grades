//
//  GPAView.swift
//  Grades
//
//  Created by Aram Soneson on 1/20/26.
//

import SwiftUI

struct GPAView: View {
	@Environment(\.horizontalSizeClass) private var horizontalSizeClass

	@State private var courses: [Course] = []
	@State private var selection: Set<UUID> = []
	@State private var editState: EditMode = .inactive
	
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
	
	private func newCourse() {
		let newCourse = Course(name: "", grade: .A, level: .regular)
		courses.append(newCourse)
	}
	
	var body: some View {
		NavigationStack {
			List(selection: $selection) {
				if !courses.isEmpty {
					GPAContent(courses: $courses, editState: $editState, focused: $focused, unweightedGPA: unweightedGPA, weightedGPA: weightedGPA)
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
							editState = .active
						}
						.disabled(courses.isEmpty)
					}
					
					ToolbarSpacer(.fixed, placement: .topBarTrailing)
					
					ToolbarItemGroup(placement: .primaryAction) {
						Button("New Course", systemImage: "plus") {
							newCourse()
						}
						.disabled(courses.count >= 20)
						
						Button("Reset", systemImage: "arrow.clockwise") {
							courses.removeAll()
						}
					}
				} else {
					if selection.count == courses.count {
						ToolbarItem(placement: .topBarTrailing) {
							Button("Deselect All") {
								selection.removeAll()
							}
						}
					} else {
						ToolbarItem(placement: .topBarTrailing) {
							Button("Select All") {
								selection = Set(courses.map { $0.id })
							}
						}
					}
					
					ToolbarItem(placement: .confirmationAction) {
						Button(role: .confirm) {
							editState = .inactive
							selection.removeAll()
						}
					}
				}
				
				ToolbarItem(placement: .bottomBar) {
					Button("Reset", systemImage: "arrow.clockwise") {
						for index in courses.indices where selection.contains(courses[index].id) {
							courses[index].name = ""
							courses[index].grade = .A
							courses[index].level = .regular
						}
					}
					.disabled(selection.isEmpty)
				}
				
				ToolbarSpacer(.flexible, placement: .bottomBar)
				
				ToolbarItem(placement: .bottomBar) {
					Button(role: .destructive) {
						courses.removeAll { course in
							selection.contains(course.id)
						}
						
						selection.removeAll()
						
						if courses.isEmpty {
							editState = .inactive
						}
					}
					.disabled(selection.isEmpty)
				}
			}
			.toolbarVisibility(editState == .inactive ? .automatic : .hidden, for: .tabBar)
			.toolbarVisibility(editState == .inactive ? .hidden : .automatic, for: .bottomBar)
			.toolbarTitleDisplayMode(.inline)
			.toolbarRole(.editor)
			.scrollDismissesKeyboard(.interactively)
			.animation(.default, value: courses)
			.animation(.default, value: selection)
			.animation(.default, value: editState)
			.environment(\.editMode, $editState)
		}
	}
}

#Preview {
	GPAView()
}
