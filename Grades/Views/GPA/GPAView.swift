//
//  GPAView.swift
//  Grades
//
//  Created by Aram Soneson on 1/20/26.
//

import SwiftUI

struct GPAView: View {
	@State private var courses: [Course] = []
	@State private var selection: Set<UUID> = []
	@State private var editState: EditMode = .inactive
	@State private var deleteConfirmationShown: Bool = false
	
	@FocusState private var focused: UUID?
	
	private var unweightedGPA: Double {
		let points: Double = courses.map { $0.grade.rawValue * $0.credits }.reduce(0, +)
		let credits: Double = courses.map { $0.credits }.reduce(0, +)
		return points / credits
	}
	private var weightedGPA: Double {
		let points: Double = courses.map { ($0.grade.rawValue > 1 ? $0.grade.rawValue + $0.level.rawValue : $0.grade.rawValue) * $0.credits }.reduce(0, +)
		let credits: Double = courses.map { $0.credits }.reduce(0, +)
		return points / credits
	}
	
	private func newCourse() {
		let newCourse = Course(name: "", grade: .A, level: .regular, credits: 1.0)
		courses.append(newCourse)
	}
	private func resetCourse(at index: Int) {
		courses[index].name = ""
		courses[index].grade = .A
		courses[index].level = .regular
		courses[index].credits = 1.0
	}
	
	var body: some View {
		NavigationStack {
			ScrollViewReader { proxy in
				List(selection: $selection) {
					if !courses.isEmpty {
						GPAContent(courses: $courses, editState: $editState, focused: $focused, unweightedGPA: unweightedGPA, weightedGPA: weightedGPA)
					}
				}
				.listStyle(.insetGrouped)
				.overlay {
					if courses.isEmpty {
						ContentUnavailableView {
							Label("No Courses", systemImage: "sum")
								.symbolVariant(.fill)
						} description: {
							Text("Courses you add will appear here.")
						}
						.background(Color(.systemGroupedBackground))
					}
				}
				.toolbar {
					ToolbarItem(placement: .title) {
						StaticNavigationTitle(title: "GPA")
					}
					
					if editState == .inactive {
						ToolbarItem(placement: .topBarTrailing) {
							Button("Select") {
								if focused != nil {
									withAnimation(.none) {
										focused = nil
									}
									
									DispatchQueue.main.async {
										withAnimation {
											editState = .active
										}
									}
								} else {
									withAnimation {
										editState = .active
									}
								}
							}
							.disabled(courses.isEmpty)
						}
						
						ToolbarSpacer(.fixed, placement: .topBarTrailing)
						
						ToolbarItemGroup(placement: .primaryAction) {
							Button("New Course", systemImage: "plus") {
								withAnimation {
									newCourse()
									proxy.scrollTo("bottom", anchor: .top)
//									focused = courses.last?.id
								}
							}
							.disabled(courses.count >= 20)
							
							Button("Reset", systemImage: "arrow.clockwise") {
								if focused != nil {
									withAnimation(.none) {
										focused = nil
									}
									
									DispatchQueue.main.async {
										withAnimation {
											courses.removeAll()
										}
									}
								} else {
									withAnimation {
										courses.removeAll()
									}
								}
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
								withAnimation {
									editState = .inactive
								}
							}
						}
					}
					
					ToolbarItem(placement: .bottomBar) {
						Button("Reset", systemImage: "arrow.clockwise") {
							for index in courses.indices where selection.contains(courses[index].id) {
								resetCourse(at: index)
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
							deleteConfirmationShown = true
						}
						.disabled(selection.isEmpty)
						.confirmationDialog("Are you sure you want to delete \(selection.count == 1 ? "this course?" : "these courses?")", isPresented: $deleteConfirmationShown, titleVisibility: .visible) {
							Button("Delete \(selection.count == 1 ? "Course" : "\(selection.count) Courses")", role: .destructive) {
								withAnimation {
									courses.removeAll { course in
										selection.contains(course.id)
									}
									
									editState = .inactive
								}
							}
						}
					}
				}
				.toolbarVisibility(editState == .inactive ? .automatic : .hidden, for: .tabBar)
				.toolbarVisibility(editState == .inactive ? .hidden : .automatic, for: .bottomBar)
				.toolbarTitleDisplayMode(.inline)
				.toolbarRole(.editor)
				.scrollDismissesKeyboard(.interactively)
				.animation(.default, value: selection)
				.environment(\.editMode, $editState)
			}
		}
	}
}

#Preview {
	GPAView()
}
