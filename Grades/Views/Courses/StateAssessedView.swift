//
//  StateAssessedView.swift
//  Grades
//
//  Created by Aram Soneson on 1/20/26.
//

import SwiftUI

struct StateAssessedView: View {
	@Environment(\.horizontalSizeClass) private var horizontalSizeClass
	
	@Binding var gradingPeriods: [GradingPeriod]
	
	private let gradingPercentage: Int = 20
	private var courseGrade: Grade {
		var letterGrade: Grade
		
		let total: Double = gradingPeriods.map { $0.grade.rawValue }.reduce(0, +)
		let average: Double = total / 5
		
		switch average {
		case 3.5...:
			letterGrade = .A
		case 2.5..<3.5:
			letterGrade = .B
		case 1.5..<2.5:
			letterGrade = .C
		case 0.75..<1.5:
			letterGrade = .D
		default:
			letterGrade = .E
		}
		
		return letterGrade
	}

	var body: some View {
		Section(header: Text("Quarter & Assessment Grades")) {
			ForEach(gradingPeriods.indices, id: \.self) { index in
				Picker(gradingPeriods[index].name, selection: $gradingPeriods[index].grade) {
					ForEach(Grade.allCases, id: \.self) { grade in
						Text(grade.description)
							.tag(grade)
					}
				}
				.pickerStyle(.menu)
				.tint(.secondary)
				.swipeActions {
					Button("Reset", systemImage: "arrow.clockwise") {
						gradingPeriods[index].grade = .A
					}
				}
				.contextMenu {
					Button("Reset", systemImage: "arrow.clockwise") {
						gradingPeriods[index].grade = .A
					}
				}
			}
		}
		
		Section(footer: Text("Each quarter grade, as well as the state assessment, is worth \(gradingPercentage.formatted(.percent)). Applies to Biology, Biology G/T, American Government, and American Government Honors.")) {
			LabeledContent("Course Grade") {
				Text(courseGrade.description)
					.monospacedDigit()
					.contentTransition(.numericText())
					.animation(.default, value: courseGrade)
			}
			.contextMenu {
				Button("Copy Course Grade", systemImage: "document.on.document") {
					copyToClipboard(courseGrade.description)
				}
			}
		}
	}
}

#Preview {
	CoursesView()
}
