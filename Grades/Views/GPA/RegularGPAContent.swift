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
			ForEach(courses.indices, id: \.self) { index in
				HStack(spacing: 16) {
					HStack {
						Text("Course \(index + 1)")
							.fontWeight(.semibold)
						
						Spacer()
					}
					
					HStack(spacing: 16) {
						Picker("Grade", selection: $courses[index].grade) {
							ForEach(Grade.allCases) { grade in
								Text(grade.description).tag(grade)
							}
						}
						.pickerStyle(.menu)
						.tint(.secondary)
						
						Picker("Type", selection: $courses[index].level) {
							ForEach(Level.allCases) { level in
								Text(level.description).tag(level)
							}
						}
						.pickerStyle(.menu)
						.tint(.secondary)
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
