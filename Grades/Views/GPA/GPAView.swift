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
	private var title: LocalizedStringKey {
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
						Label("No Courses", systemImage: "chart.bar")
							.symbolVariant(.fill)
					} description: {
						Text("Courses you add will appear here.")
					}
					.background(Color(.systemGroupedBackground))
				}
			}
			.toolbar {
				ToolbarItem(placement: .title) {
					StaticNavigationTitle(title: title)
				}
				
				if editState == .inactive {
					ToolbarItem(placement: .topBarTrailing) {
						Button("Select") {
							if focused != nil {
								withAnimation(.none) {
									focused = nil
								}
								
								DispatchQueue.main.async {
									editState = .active
								}
							} else {
								editState = .active
							}
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
						Button("Confirm", systemImage: "checkmark", role: .confirm) {
							editState = .inactive
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
					ZStack {
						Text("00 selected")
							.monospacedDigit()
							.opacity(0)
						
						if editState == .active {
							Text("\(selection.count) selected")
								.monospacedDigit()
								.contentTransition(.numericText())
						}
					}
					.padding(.horizontal, 10)
				}
				
				ToolbarSpacer(.flexible, placement: .bottomBar)
				
				ToolbarItem(placement: .bottomBar) {
					Button("Delete", systemImage: "trash", role: .destructive) {
						courses.removeAll { course in
							selection.contains(course.id)
						}
						
						editState = .inactive
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
