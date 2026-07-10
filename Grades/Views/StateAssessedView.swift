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
	private var navigationTitle: LocalizedStringKey {
		switch horizontalSizeClass {
		case .regular:
			"State-Assessed Courses"
		case .compact, .none, .some:
			"State-Assessed"
		}
	}
	
	var body: some View {
		NavigationStack {
			Form {
				Section(header: Text("Quarter & Assessment Grades")) {
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
				
				Section(footer: Text("Each quarter grade, as well as the state assessment, is worth \(gradingPercentage.formatted(.percent)). Applies to Biology, Biology G/T, American Government, and American Government Honors.")) {
					CopyableRow(
						label: "Course Grade",
						value: courseGrade.description
					)
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
			.scrollEdgeEffectStyle(.soft, for: .all)
		}
	}
}

#Preview {
	StateAssessedView()
}
