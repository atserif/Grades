//
//  SemesterView.swift
//  Grades
//
//  Created by Aram Soneson on 1/20/26.
//

import SwiftUI

struct SemesterView: View {
	@Environment(\.horizontalSizeClass) private var horizontalSizeClass
	
	@State private var copyButtonHovered: Bool = false
	@State private var copyButtonClicked: Bool = false
	
	@State private var q1Grade: Grades = .A
	@State private var q2Grade: Grades = .A
	@State private var finalGrade: Grades = .A
		
	private var courseGrade: Grades {
		var letterGrade: Grades
		
		let weightedTotal: Double = ((q1Grade.rawValue + q2Grade.rawValue) * 2) + finalGrade.rawValue
		let average: Double = weightedTotal / 5
		
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
			"Semester"
		} else {
			"Semester Courses"
		}
	}
	
	var body: some View {
		NavigationStack {
			Form {
				Section(header: Text("Quarter & Exam Grades")) {
					Picker("Quarter 1", selection: $q1Grade) {
						ForEach(Grades.allCases) { grade in
							Text(grade.description).tag(grade)
						}
					}
					
					Picker("Quarter 2", selection: $q2Grade) {
						ForEach(Grades.allCases) { grade in
							Text(grade.description).tag(grade)
						}
					}
					
					Picker("Final", selection: $finalGrade) {
						ForEach(Grades.allCases) { grade in
							Text(grade.description).tag(grade)
						}
					}
				}
				
				Section(footer: Text("Each quarter grade is worth 40%. The final exam is worth 20%.")) {
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
						q1Grade = .A
						q2Grade = .A
						finalGrade = .A
					}
				}
			}
		}
	}
}

#Preview {
	SemesterView()
}
