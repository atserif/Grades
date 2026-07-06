//
//  RegularGPAContent.swift
//  Grades
//
//  Created by Aram Soneson on 6/12/26.
//

import SwiftUI

struct RegularGPAContent: View {
	@Binding var courses: [Course]
	
	let unweightedGPA: Double
	let weightedGPA: Double
	
	var body: some View {
		Section(header: Text("Course Grades & Types")) {
			ForEach($courses) { course in
				HStack(spacing: 16) {
					TextField("Course Name", text: course.name, prompt: Text("Course Name"))
						.fontWeight(.semibold)
						.submitLabel(.done)
						.autocorrectionDisabled()
						.labelsHidden()
						.writingToolsBehavior(.disabled)
						.writingToolsAffordanceVisibility(.hidden)
					
					HStack(spacing: 16) {
						Picker("Grade", selection: course.grade) {
							ForEach(Grade.allCases, id: \.self) { grade in
								Text(grade.description).tag(grade)
							}
						}
						.pickerStyle(.menu)
						#if os(iOS)
						.tint(.secondary)
						#endif
						
						Picker("Type", selection: course.level) {
							ForEach(Level.allCases, id: \.self) { level in
								Text(level.description).tag(level)
							}
						}
						.pickerStyle(.menu)
						#if os(iOS)
						.tint(.secondary)
						#endif
					}
				}
				.swipeActions(edge: .trailing, allowsFullSwipe: true) {
					Button("Delete", systemImage: "trash", role: .destructive) {
						withAnimation {
							courses.removeAll { $0.id == course.id }
						}
					}
					
					Button("Reset", systemImage: "arrow.clockwise") {
						course.name.wrappedValue = "New Course"
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
						course.name.wrappedValue = "New Course"
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
				LabeledContent("Unweighted GPA", value: String(unweightedGPA.formatted(.number.precision(.fractionLength(1...3)))))
					.contentTransition(.numericText())
					.animation(.default, value: unweightedGPA)
				
				LabeledContent("Weighted GPA", value: String(weightedGPA.formatted(.number.precision(.fractionLength(1...3)))))
					.contentTransition(.numericText())
					.animation(.default, value: weightedGPA)
			}
			.contextMenu {
				Button("Copy Unweighted", systemImage: "document.on.document") {
					Copy.copyToClipboard(String(unweightedGPA.formatted(.number.precision(.fractionLength(1...3)))))
				}
				
				Button("Copy Weighted", systemImage: "document.on.document") {
					Copy.copyToClipboard(String(weightedGPA.formatted(.number.precision(.fractionLength(1...3)))))
				}
			}
			#endif
		}
	}
}

#Preview {
	ContentView()
}
