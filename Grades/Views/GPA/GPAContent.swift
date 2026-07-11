//
//  GPAContent.swift
//  Grades
//
//  Created by Aram Soneson on 6/12/26.
//

import SwiftUI

struct GPAContent: View {
	@Environment(\.horizontalSizeClass) private var horizontalSizeClass
	
	@Binding var courses: [Course]
	@Binding var editState: EditMode
	
	var focused: FocusState<UUID?>.Binding
	
	let unweightedGPA: Double
	let weightedGPA: Double
	
	var body: some View {
		Section(header: Text("Course Grades & Types")) {
			ForEach($courses) { course in
				Group {
					switch horizontalSizeClass {
					case .regular:
						HStack(spacing: 16) {
							GPARow(course: course, focused: focused)
						}
					case .compact, .none, .some:
						VStack(alignment: .leading) {
							GPARow(course: course, focused: focused)
						}
					}
				}
				.id(course.id)
				.disabled(editState != .inactive)
				.swipeActions(edge: .trailing, allowsFullSwipe: true) {
					Button("Delete", systemImage: "trash", role: .destructive) {
						courses.removeAll { $0.id == course.id }
					}
					
					Button("Reset", systemImage: "arrow.clockwise") {
						course.name.wrappedValue = ""
						course.grade.wrappedValue = .A
						course.level.wrappedValue = .regular
					}
				}
				.contextMenu {
					Button("Duplicate", systemImage: "plus.square.on.square") {
						if let selectedIndex = courses.firstIndex(where: { $0.id == course.id }) {
							let duplicatedCourse = Course(name: course.name.wrappedValue, grade: course.grade.wrappedValue, level: course.level.wrappedValue)
							courses.insert(duplicatedCourse, at: courses.index(after: selectedIndex))
						}
					}
					
					Button("Reset", systemImage: "arrow.clockwise") {
						course.name.wrappedValue = ""
						course.grade.wrappedValue = .A
						course.level.wrappedValue = .regular
					}
					
					Divider()
					
					Button("Delete", systemImage: "trash", role: .destructive) {
						courses.removeAll { $0.id == course.id }
					}
				}
			}
		}
		
		Section(footer: Text("Regular courses are worth 4.0 points, Honors courses are worth 4.5 points, and G/T & AP courses are worth 5.0 points.")) {
			HStack(spacing: 16) {
				LabeledContent("Unweighted") {
					Text(unweightedGPA.formatted(.number.precision(.fractionLength(1...3))))
						.monospacedDigit()
						.contentTransition(.numericText())
						.animation(.default, value: unweightedGPA)
				}
				
				LabeledContent("Weighted") {
					Text(weightedGPA.formatted(.number.precision(.fractionLength(1...3))))
						.monospacedDigit()
						.contentTransition(.numericText())
						.animation(.default, value: weightedGPA)
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
	}
}

#Preview {
	GPAView()
}
