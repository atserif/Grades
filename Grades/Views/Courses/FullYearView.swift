//
//  FullYearView.swift
//  Grades
//
//  Created by Aram Soneson on 1/20/26.
//

import SwiftUI

struct FullYearView: View {
	@Binding var gradingPeriods: [GradingPeriod]
	
	private var courseGrade: Grade {
		var letterGrade: Grade
		
		let quarterTotal: Double = gradingPeriods.filter { $0.type == .quarter }.map { $0.grade.rawValue }.reduce(0, +) * 22.5
		let examTotal: Double = gradingPeriods.filter { $0.type == .exam }.map { $0.grade.rawValue }.reduce(0, +) * 10
		let average: Double = (quarterTotal + examTotal) / 100
		
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
		Section {
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
		} header: {
			Text("Quarter & Exam Grades")
		}
		
		Section {
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
