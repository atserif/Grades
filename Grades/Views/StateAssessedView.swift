//
//  StateAssessedView.swift
//  Grades
//
//  Created by Aram Soneson on 1/20/26.
//

import SwiftUI

struct StateAssessedView: View {
	@Environment(\.horizontalSizeClass) private var horizontalSizeClass
	
	@State private var gradingPeriods: [GradingPeriod] = [
		GradingPeriod(name: "Quarter 1", grade: .A),
		GradingPeriod(name: "Quarter 2", grade: .A),
		GradingPeriod(name: "Quarter 3", grade: .A),
		GradingPeriod(name: "Quarter 4", grade: .A),
		GradingPeriod(name: "State Assessment", grade: .A)
	]
		
	private var courseGrade: Grades {
		var letterGrade: Grades
		
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
	
	private var navigationTitle: String {
		if horizontalSizeClass == .compact {
			"State"
		} else {
			"State-Assessed Courses"
		}
	}
	
	var body: some View {
		NavigationStack {
			Form {
				Section(header: Text("Quarter & Assessment Grades")) {
					ForEach(gradingPeriods.indices, id: \.self) { index in
						Picker(gradingPeriods[index].name, selection: $gradingPeriods[index].grade) {
							ForEach(Grades.allCases) { grade in
								Text(grade.description).tag(grade)
							}
						}
					}
				}
				
				Section(footer: Text("Quarter grades and the state assessment are each worth 20%. Applies to Biology, Biology G/T, American Government, and American Government Honors.")) {
					#if os(macOS)
					CopyableRow(
						label: "Course Grade",
						value: courseGrade.description
					)
					#else
					LabeledContent("Course Grade", value: courseGrade.description)
						.contextMenu {
							Button("Copy Course Grade", systemImage: "document.on.document") {
								Copy.copyToClipboard(courseGrade.description)
							}
						}
					#endif
				}
			}
			.formStyle(.grouped)
			.navigationTitle(navigationTitle)
			.toolbarTitleDisplayMode(.inlineLarge)
			.toolbar {
				ToolbarItem(placement: .primaryAction) {
					Button("Reset", systemImage: "arrow.counterclockwise") {
						gradingPeriods.indices.forEach { gradingPeriods[$0].grade = .A }
					}
				}
			}
		}
	}
}

#Preview {
	StateAssessedView()
}
