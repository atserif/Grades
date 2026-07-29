//
//  CoursesView.swift
//  Grades
//
//  Created by Aram Soneson on 7/12/26.
//

import SwiftUI

private enum CalculatorSelection: CaseIterable {
	case fullYear
	case semester
	case stateAssessed
	
	var description: String {
		switch self {
		case .fullYear: "Full Year"
		case .semester: "Semester"
		case .stateAssessed: "State-Assessed"
		}
	}
}

struct CoursesView: View {
	@State private var calculatorSelection: CalculatorSelection = .fullYear
	@State private var fullYearGradingPeriods: [GradingPeriod] = [
		GradingPeriod(name: "Quarter 1", grade: .A),
		GradingPeriod(name: "Quarter 2", grade: .A),
		GradingPeriod(name: "Midterm", grade: .A),
		GradingPeriod(name: "Quarter 3", grade: .A),
		GradingPeriod(name: "Quarter 4", grade: .A),
		GradingPeriod(name: "Final", grade: .A)
	]
	@State private var semesterGradingPeriods: [GradingPeriod] = [
		GradingPeriod(name: "Quarter 1", grade: .A),
		GradingPeriod(name: "Quarter 2", grade: .A),
		GradingPeriod(name: "Final", grade: .A),
	]
	@State private var stateAssessedGradingPeriods: [GradingPeriod] = [
		GradingPeriod(name: "Quarter 1", grade: .A),
		GradingPeriod(name: "Quarter 2", grade: .A),
		GradingPeriod(name: "Quarter 3", grade: .A),
		GradingPeriod(name: "Quarter 4", grade: .A),
		GradingPeriod(name: "State Assessment", grade: .A)
	]
	
	var body: some View {
		NavigationStack {
			Form {
				Section {
					Picker("Grading Format", selection: $calculatorSelection) {
						ForEach(CalculatorSelection.allCases, id: \.self) { calculator in
							Text(calculator.description)
								.tag(calculator)
						}
					}
					.pickerStyle(.segmented)
					.controlSize(.extraLarge)
					.listRowInsets(EdgeInsets(top: 0, leading: 0, bottom: 1, trailing: 0))
					.listRowBackground(Color.clear)
				}
				
				switch calculatorSelection {
				case .fullYear:
					FullYearView(gradingPeriods: $fullYearGradingPeriods)
				case .semester:
					SemesterView(gradingPeriods: $semesterGradingPeriods)
				case .stateAssessed:
					StateAssessedView(gradingPeriods: $stateAssessedGradingPeriods)
				}
			}
			.formStyle(.grouped)
			.toolbar {
				ToolbarItem(placement: .title) {
					StaticNavigationTitle(title: "Courses")
				}
				
				ToolbarItem(placement: .primaryAction) {
					Button("Reset", systemImage: "arrow.clockwise") {
						calculatorSelection = .fullYear
						
						fullYearGradingPeriods.indices.forEach { fullYearGradingPeriods[$0].grade = .A }
						semesterGradingPeriods.indices.forEach { semesterGradingPeriods[$0].grade = .A }
						stateAssessedGradingPeriods.indices.forEach { stateAssessedGradingPeriods[$0].grade = .A }
					}
				}
			}
			.toolbarTitleDisplayMode(.inline)
			.toolbarRole(.editor)
			.contentMargins(.top, 16)
		}
	}
}

#Preview {
	CoursesView()
}
