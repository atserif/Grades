//
//  GPAContent.swift
//  Grades
//
//  Created by Aram Soneson on 6/12/26.
//

import SwiftUI

struct GPAContent: View {
	@Binding var courses: [Course]
	@Binding var editState: EditMode
	
	var focused: FocusState<UUID?>.Binding
	let unweightedGPA: Double
	let weightedGPA: Double
	
	private func resetCourse(_ course: Binding<Course>) {
		course.name.wrappedValue = "Course \(course.wrappedValue.number)"
		course.grade.wrappedValue = .A
		course.level.wrappedValue = .regular
		course.credits.wrappedValue = 1.0
	}
	
	var body: some View {
		Section {
			ForEach($courses, editActions: .move) { course in
				GPARow(course: course, editState: $editState, focused: focused)
					// Prevents horizontal ScrollView from clipping when scrolled
					.listRowInsets(EdgeInsets(top: 16, leading: 0, bottom: 16, trailing: 0))
					.alignmentGuide(.listRowSeparatorLeading) { _ in 16 }
					.swipeActions {
						Button("Delete", systemImage: "trash", role: .destructive) {
							withAnimation {
								courses.removeAll { $0.id == course.id }
								
								if courses.isEmpty {
									editState = .inactive
								}
							}
						}
						
						Button("Reset", systemImage: "arrow.clockwise") {
							resetCourse(course)
						}
					}
					.contextMenu {
						Button("Rename", systemImage: "pencil") {
							if editState != .inactive {
								withAnimation {
									editState = .inactive
								}
							}
							
							focused.wrappedValue = course.id
						}
						
						Button("Reset", systemImage: "arrow.clockwise") {
							if focused.wrappedValue == course.id {
								focused.wrappedValue = nil
							}
							
							resetCourse(course)
						}
						
						Divider()
						
						Button("Delete", systemImage: "trash", role: .destructive) {
							if focused.wrappedValue == course.id {
								withAnimation(.none) {
									focused.wrappedValue = nil
								}
								
								DispatchQueue.main.async {
									withAnimation {
										courses.removeAll { $0.id == course.id }
										
										if courses.isEmpty {
											editState = .inactive
										}
									}
								}
							} else {
								withAnimation {
									courses.removeAll { $0.id == course.id }
									
									if courses.isEmpty {
										editState = .inactive
									}
								}
							}
						}
					}
					.id(course.id)
					// Fixes animation issues when allowsHitTesting is toggled
					.geometryGroup()
			}
		} header: {
			Text("Course Grades, Levels, & Credits")
		}
		
		Section {
			HStack(spacing: 16) {
				LabeledContent {
					Text(unweightedGPA.formatted(.number.precision(.fractionLength(1...3))))
						.monospacedDigit()
						.contentTransition(.numericText())
						.animation(.default, value: unweightedGPA)
				} label: {
					Text("Unweighted")
				}
				.frame(maxWidth: .infinity, alignment: .leading)
				
				// Replicates default List row separator styling
				Rectangle()
					.fill(Color(.separator))
					.frame(width: 1)
				
				LabeledContent {
					Text(weightedGPA.formatted(.number.precision(.fractionLength(1...3))))
						.monospacedDigit()
						.contentTransition(.numericText())
						.animation(.default, value: weightedGPA)
				} label: {
					Text("Weighted")
				}
				.frame(maxWidth: .infinity, alignment: .leading)
			}
		}
		.contextMenu {
			Button("Copy Unweighted", systemImage: "document.on.document") {
				copyToClipboard(unweightedGPA.formatted(.number.precision(.fractionLength(1...3))))
			}
			
			Button("Copy Weighted", systemImage: "document.on.document") {
				copyToClipboard(weightedGPA.formatted(.number.precision(.fractionLength(1...3))))
			}
		}
		.id("bottom")
	}
}

#Preview {
	GPAView()
}
