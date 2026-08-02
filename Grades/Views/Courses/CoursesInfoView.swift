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
				
				Section {
					Text("All grade calculation information is derived from [Howard County Public School System Policy 8020](https://policy.hcpss.org/8000/8020/).")
						.font(.subheadline)
						.foregroundStyle(.secondary)
				}
				.listRowBackground(Color.clear)
				.listRowInsets(EdgeInsets(top: 0, leading: 16, bottom: 0, trailing: 16))
			}
			.listSectionSpacing(.compact)
			.toolbar {
				ToolbarItem(placement: .cancellationAction) {
					Button("Close", systemImage: "xmark", role: .close) {
						dismiss()
					}
				}
			}
			.navigationTitle("About Courses")
			.toolbarTitleDisplayMode(.inline)
			.scrollEdgeEffectStyle(.soft, for: .all)
			.contentMargins(.top, 10)
		}
	}
}

#Preview {
	VStack { }
		.sheet(isPresented: .constant(true)) {
			CoursesInfoView()
				.presentationRimLight()
				.interactiveDismissDisabled()
		}
}
