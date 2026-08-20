//
//  GPAView.swift
//  Grades
//
//  Created by Aram Soneson on 1/20/26.
//

import SwiftUI

struct GPAView: View {
	@Environment(\.horizontalSizeClass) private var horizontalSizeClass
	@Environment(\.accessibilityShowBorders) private var accessibilityShowBorders
	
	@State private var courses: [Course] = []
	@State private var selection: Set<UUID> = []
	@State private var editState: EditMode = .inactive
	@State private var infoSheetPresented: Bool = false
	@State private var courseNumber: Int = 0
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
		courseNumber += 1
		let newCourse = Course(number: courseNumber, name: "Course \(courseNumber)", grade: .A, level: .regular, credits: 1.0)
		
		courses.append(newCourse)
	}
	private func resetCourse(at index: Int) {
		courses[index].name = "Course \(courses[index].number)"
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
				.onChange(of: selection) {
					if editState == .inactive {
						selection.removeAll()
					}
				}
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
				// Multiple selection context menu
				.contextMenu(forSelectionType: Course.ID.self) { selectedCourses in
					if selectedCourses.isEmpty { } else if selection.count > 1 {
						Button("Reset", systemImage: "arrow.clockwise") {
							for index in courses.indices {
								if selectedCourses.contains(courses[index].id) {
									resetCourse(at: index)
								}
							}
						}
						
						Divider()
						
						Button("Delete", systemImage: "trash", role: .destructive) {
							// Avoids animation conflicts by delaying
							DispatchQueue.main.asyncAfter(deadline: .now() + 0.75) {
								withAnimation {
									courses.removeAll { selectedCourses.contains($0.id) }
								}
								
								selection.removeAll()
								
								if courses.isEmpty {
									withAnimation {
										editState = .inactive
									}
								}
							}
						}
					}
				}
				.toolbar {
					ToolbarItem(placement: .title) {
						StaticNavigationTitle(title: "GPA")
					}
					
					if editState == .inactive {
						ToolbarItem(placement: .topBarTrailing) {
							Button {
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
							} label: {
								Text("Select")
									// Fixes default styling when Show Borders is enabled
									.padding(.horizontal, accessibilityShowBorders ? 12 : 0)
									.underline(false)
							}
							.disabled(courses.isEmpty)
						}
						
						ToolbarSpacer(.fixed, placement: .topBarTrailing)
						
						ToolbarItemGroup(placement: .primaryAction) {
							Button("New Course", systemImage: "plus") {
								withAnimation {
									newCourse()
									proxy.scrollTo("bottom", anchor: .top)
								}
							}
							.disabled(courses.count >= 20)
							
							Menu("More", systemImage: "ellipsis") {
								Button("About GPA", systemImage: "info.circle") {
									infoSheetPresented = true
								}
								
								Divider()
								
								Button("Reset", systemImage: "arrow.clockwise") {
									if focused != nil {
										withAnimation(.none) {
											focused = nil
										}
										
										DispatchQueue.main.async {
											withAnimation {
												courses.removeAll()
											}
											
											courseNumber = 0
										}
									} else {
										withAnimation {
											courses.removeAll()
										}
										
										courseNumber = 0
									}
								}
							}
						}
					} else {
						if selection.count == courses.count {
							ToolbarItem(placement: .topBarTrailing) {
								Button {
									selection.removeAll()
								} label: {
									Text("Deselect All")
										// Fixes default styling when Show Borders is enabled
										.padding(.horizontal, accessibilityShowBorders ? 12 : 0)
										.underline(false)
								}
							}
						} else {
							ToolbarItem(placement: .topBarTrailing) {
								Button {
									selection = Set(courses.map { $0.id })
								} label: {
									Text("Select All")
										// Fixes default styling when Show Borders is enabled
										.padding(.horizontal, accessibilityShowBorders ? 12 : 0)
										.underline(false)
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
					
					ToolbarSpacer(horizontalSizeClass == .regular ? .fixed : .flexible, placement: .bottomBar)
					
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
						.padding(.horizontal, 12)
						.fixedSize(horizontal: true, vertical: false)
					}
					
					ToolbarSpacer(horizontalSizeClass == .regular ? .fixed : .flexible, placement: .bottomBar)
					
					ToolbarItem(placement: .bottomBar) {
						Button("Delete", systemImage: "trash", role: .destructive) {
							withAnimation {
								courses.removeAll { course in
									selection.contains(course.id)
								}
								
								editState = .inactive
							}
						}
						.disabled(selection.isEmpty)
					}
				}
				.sheet(isPresented: $infoSheetPresented) {
					GPAInfoView()
				}
				.toolbarVisibility(editState == .inactive ? .visible : .hidden, for: .tabBar)
				.toolbarVisibility(editState == .inactive ? .hidden : .visible, for: .bottomBar)
				.toolbarTitleDisplayMode(.inline)
				.toolbarRole(.editor)
				.scrollEdgeEffectStyle(.soft, for: .top)
				.scrollDismissesKeyboard(.immediately)
				.animation(.default, value: selection)
				.environment(\.editMode, $editState)
			}
		}
	}
}

#Preview {
	GPAView()
}
