//
//  CoursesInfoView.swift
//  Grades
//
//  Created by Aram Soneson on 7/29/26.
//

import SwiftUI

struct CoursesInfoView: View {
	@Environment(\.dismiss) private var dismiss
	
	private let fullYearQuarterPercentage: Int = 20
	private let fullYearExamPercentage: Int = 10
	private let semesterQuarterPercentage: Int = 40
	private let semesterExamPercentage: Int = 20
	private let stateAssessedGradingPercentage: Int = 20

	var body: some View {
		NavigationStack {
			List {
				Section {
					Text("Full Year")
						.font(.headline)
					
					Text("Quarter grades are worth \(fullYearQuarterPercentage.formatted(.percent)) each. The midterm and final exams are worth \(fullYearExamPercentage.formatted(.percent)) each.")
						.font(.subheadline)
						.foregroundStyle(.secondary)
				}
				
				Section {
					Text("Semester")
						.font(.headline)
					
					Text("Quarter grades are worth \(semesterQuarterPercentage.formatted(.percent)) each. The final exam is worth \(semesterExamPercentage.formatted(.percent)).")
						.font(.subheadline)
						.foregroundStyle(.secondary)
				}
				
				Section {
					Text("State-Assessed")
						.font(.headline)
					
					Text("Quarter grades, as well as the state assessment, are worth \(stateAssessedGradingPercentage.formatted(.percent)) each.")
						.font(.subheadline)
						.foregroundStyle(.secondary)
				}
			}
			.listSectionSpacing(.compact)
			.toolbar {
				ToolbarItem(placement: .cancellationAction) {
					Button("Cancel", systemImage: "xmark", role: .cancel) {
						dismiss()
					}
				}
			}
			.navigationTitle("About Courses")
		}
	}
}

#Preview {
	CoursesInfoView()
}
