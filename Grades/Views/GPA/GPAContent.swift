//
//  CompactGPAContent.swift
//  Grades
//
//  Created by Aram Soneson on 6/12/26.
//

import SwiftUI

struct GPAContent: View {
	@Environment(\.horizontalSizeClass) private var horizontalSizeClass
	
	@Binding var editState: EditMode
	@Binding var courses: [Course]
	
	var focused: FocusState<UUID?>.Binding
	
	let unweightedGPA: Double
	let weightedGPA: Double
	
	var body: some View {
		Section(header: Text("Course Grades & Types")) {
			ForEach($courses) { course in
				Group {
					switch horizontalSizeClass {
					case .regular:
						RegularGPARow(course: course, focused: focused)
					case .compact, .none, .some:
						CompactGPARow(course: course, focused: focused)
					}
				}
				.id(course.id)
				.geometryGroup()
				.allowsHitTesting(editState == .inactive)
				.swipeActions(edge: .trailing, allowsFullSwipe: true) {
					Button("Delete", systemImage: "trash", role: .destructive) {
						withAnimation {
							courses.removeAll { $0.id == course.id }
						}
					}
					
					Button("Reset", systemImage: "arrow.clockwise") {
						course.name.wrappedValue = ""
						course.grade.wrappedValue = .A
						course.level.wrappedValue = .regular
					}
				}
				.contextMenu {
					Button("Duplicate", systemImage: "plus.square.on.square") {
						withAnimation {
							if let selectedIndex = courses.firstIndex(where: { $0.id == course.id }) {
								let duplicatedCourse = Course(name: course.name.wrappedValue, grade: course.grade.wrappedValue, level: course.level.wrappedValue)
								courses.insert(duplicatedCourse, at: courses.index(after: selectedIndex))
							}
						}
					}
					
					Button("Reset", systemImage: "arrow.clockwise") {
						course.name.wrappedValue = ""
						course.grade.wrappedValue = .A
						course.level.wrappedValue = .regular
					}
					
					Divider()
					
					Button("Delete", systemImage: "trash", role: .destructive) {
						withAnimation {
							courses.removeAll { $0.id == course.id }
						}
					}
				}
			}
		}
		
		Section(footer: Text("Regular courses are worth 4.0 points, Honors courses are worth 4.5 points, and G/T & AP courses are worth 5.0 points.")) {
			#if os(macOS)
			HStack(spacing: 16) {
				CopyableRow(
					label: "Unweighted GPA",
					value: String(unweightedGPA.formatted(.number.precision(.fractionLength(1...3))))
				)
				
				CopyableRow(
					label: "Weighted GPA",
					value: String(weightedGPA.formatted(.number.precision(.fractionLength(1...3))))
				)
			}
			#else
			HStack(spacing: 16) {
				LabeledContent("Unweighted") {
					Text(unweightedGPA.formatted(.number.precision(.fractionLength(1...3))))
						.monospacedDigit()
				}
				.contentTransition(.numericText())
				.animation(.default, value: unweightedGPA)
				
				LabeledContent("Weighted") {
					Text(weightedGPA.formatted(.number.precision(.fractionLength(1...3))))
						.monospacedDigit()
				}
				.contentTransition(.numericText())
				.animation(.default, value: weightedGPA)
			}
			.contextMenu {
				Button("Copy Unweighted", systemImage: "document.on.document") {
					Copy.copyToClipboard(unweightedGPA.formatted(.number.precision(.fractionLength(1...3))))
				}
				
				Button("Copy Weighted", systemImage: "document.on.document") {
					Copy.copyToClipboard(weightedGPA.formatted(.number.precision(.fractionLength(1...3))))
				}
			}
			#endif
		}
	}
}

#Preview {
	ContentView()
}
