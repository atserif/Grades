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
		course.name.wrappedValue = ""
		course.grade.wrappedValue = .A
		course.level.wrappedValue = .regular
		course.credits.wrappedValue = 1.0
	}
	
	var body: some View {
		Section(header: Text("Course Grades, Levels, & Credits")) {
			ForEach($courses, editActions: .move) { course in
				GPARow(course: course, editState: $editState, focused: focused)
					.id(course.id)
					.listRowInsets(EdgeInsets(top: 16, leading: 0, bottom: 16, trailing: 0))
					.alignmentGuide(.listRowSeparatorLeading) { _ in 16 }
					.allowsHitTesting(editState == .inactive)
					.geometryGroup()
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
						Button("Reset", systemImage: "arrow.clockwise") {
							resetCourse(course)
						}
						
						Divider()
						
						Button("Delete", systemImage: "trash", role: .destructive) {
							withAnimation {
								courses.removeAll { $0.id == course.id }
								
								if courses.isEmpty {
									editState = .inactive
								}
							}
						}
					}
			}
		}
		
		Section(footer: Text("Regular courses are worth 4.0 points, Honors courses are worth 4.5 points, and G/T & AP courses are worth 5.0 points.")) {
			ViewThatFits {
				HStack(spacing: 16) {
					HStack {
						Text("Unweighted")
							.fixedSize()
						
						Spacer()
						
						Text(unweightedGPA.formatted(.number.precision(.fractionLength(1...3))))
							.foregroundStyle(.secondary)
							.monospacedDigit()
							.contentTransition(.numericText())
							.animation(.default, value: unweightedGPA)
							.fixedSize()
					}
					.frame(maxWidth: .infinity, alignment: .leading)
					
					Rectangle()
						.fill(Color(.separator))
						.frame(width: 1)
					
					HStack {
						Text("Weighted")
							.fixedSize()
						
						Spacer()
						
						Text(weightedGPA.formatted(.number.precision(.fractionLength(1...3))))
							.foregroundStyle(.secondary)
							.monospacedDigit()
							.contentTransition(.numericText())
							.animation(.default, value: weightedGPA)
							.fixedSize()
					}
					.frame(maxWidth: .infinity, alignment: .leading)
				}
				
				HStack(spacing: 16) {
					VStack(alignment: .leading) {
						Text("Unweighted")
						
						Spacer(minLength: 0)
						
						Text(unweightedGPA.formatted(.number.precision(.fractionLength(1...3))))
							.foregroundStyle(.secondary)
							.monospacedDigit()
							.contentTransition(.numericText())
							.animation(.default, value: unweightedGPA)
					}
					.frame(maxWidth: .infinity, alignment: .leading)
					
					Rectangle()
						.fill(Color(.separator))
						.frame(width: 1)
					
					VStack(alignment: .leading) {
						Text("Weighted")
						
						Spacer(minLength: 0)
						
						Text(weightedGPA.formatted(.number.precision(.fractionLength(1...3))))
							.foregroundStyle(.secondary)
							.monospacedDigit()
							.contentTransition(.numericText())
							.animation(.default, value: weightedGPA)
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
		}
		.id("bottom")
	}
}

#Preview {
	GPAView()
}
