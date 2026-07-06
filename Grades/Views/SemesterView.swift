//
//  SemesterView.swift
//  Grades
//
//  Created by Aram Soneson on 1/20/26.
//

import SwiftUI

struct SemesterView: View {
	@Environment(\.horizontalSizeClass) private var horizontalSizeClass
	
	@State private var gradingPeriods: [GradingPeriod] = [
		GradingPeriod(name: "Quarter 1", grade: .A),
		GradingPeriod(name: "Quarter 2", grade: .A),
		GradingPeriod(name: "Final", grade: .A),
	]
	
	private var courseGrade: Grade {
		var letterGrade: Grade
		
		let quarterTotal: Double = gradingPeriods.filter{ $0.name.hasPrefix("Quarter ") }.map { $0.grade.rawValue }.reduce(0, +) * 2
		let examTotal: Double = gradingPeriods.filter{ !$0.name.hasPrefix("Quarter ") }.map { $0.grade.rawValue }.reduce(0, +)
		let average: Double = (quarterTotal + examTotal) / 5
		
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
	private var navigationTitle: String {
		switch horizontalSizeClass {
		case .regular:
			"Semester Courses"
		case .compact, .none, .some:
			"Semester"
		}
	}
	
	var body: some View {
		NavigationStack {
			Form {
				Section(header: Text("Quarter & Exam Grades")) {
					ForEach(gradingPeriods.indices, id: \.self) { index in
						Picker(gradingPeriods[index].name, selection: $gradingPeriods[index].grade) {
							ForEach(Grade.allCases, id: \.self) { grade in
								Text(grade.description).tag(grade)
							}
						}
						.pickerStyle(.menu)
						#if os(iOS)
						.tint(.secondary)
						#endif
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
				
				Section(footer: Text("Each quarter grade is worth 40%. The final exam is worth 20%.")) {
					CopyableRow(
						label: "Course Grade",
						value: courseGrade.description
					)
				}
			}
			.formStyle(.grouped)
			.navigationTitle(navigationTitle)
			.toolbarTitleDisplayMode(.inlineLarge)
			.toolbar {
				ToolbarItem(placement: .primaryAction) {
					Button("Reset", systemImage: "arrow.clockwise") {
						gradingPeriods.indices.forEach { gradingPeriods[$0].grade = .A }
					}
				}
			}
		}
	}
}

#Preview {
	ContentView()
}
