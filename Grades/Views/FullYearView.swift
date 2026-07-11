//
//  FullYearView.swift
//  Grades
//
//  Created by Aram Soneson on 1/20/26.
//

import SwiftUI

struct FullYearView: View {
	@Environment(\.horizontalSizeClass) private var horizontalSizeClass
	
	@State private var gradingPeriods: [GradingPeriod] = [
		GradingPeriod(name: "Quarter 1", grade: .A),
		GradingPeriod(name: "Quarter 2", grade: .A),
		GradingPeriod(name: "Midterm", grade: .A),
		GradingPeriod(name: "Quarter 3", grade: .A),
		GradingPeriod(name: "Quarter 4", grade: .A),
		GradingPeriod(name: "Final", grade: .A)
	]
	
	private let quarterPercentage: Int = 20
	private let examPercentage: Int = 10
	private var courseGrade: Grade {
		var letterGrade: Grade
		
		let quarterTotal: Double = gradingPeriods.filter { $0.name.hasPrefix("Quarter ") }.map { $0.grade.rawValue }.reduce(0, +) * 2
		let examTotal: Double = gradingPeriods.filter { !$0.name.hasPrefix("Quarter ") }.map { $0.grade.rawValue }.reduce(0, +)
		let average: Double = (quarterTotal + examTotal) / 10
		
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
	private var navigationTitle: LocalizedStringKey {
		switch horizontalSizeClass {
		case .regular:
			"Full Year Courses"
		case .compact, .none, .some:
			"Full Year"
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
						.tint(.secondary)
						.swipeActions(edge: .trailing, allowsFullSwipe: true) {
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
				
				Section(footer: Text("Each quarter grade is worth \(quarterPercentage.formatted(.percent)). The midterm and final exams are worth \(examPercentage.formatted(.percent)) each.")) {
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
			.formStyle(.grouped)
			.toolbar {
				ToolbarItem(placement: .title) {
					StaticNavigationTitle(title: navigationTitle)
				}
				
				ToolbarItem(placement: .primaryAction) {
					Button("Reset", systemImage: "arrow.clockwise") {
						gradingPeriods.indices.forEach { gradingPeriods[$0].grade = .A }
					}
				}
			}
			.toolbarTitleDisplayMode(.inline)
			.toolbarRole(.editor)
		}
	}
}

#Preview {
	FullYearView()
}
