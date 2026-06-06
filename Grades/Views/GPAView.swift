//
//  GPAView.swift
//  Grades
//
//  Created by Aram Soneson on 1/20/26.
//

import SwiftUI

struct GPAView: View {
	@Environment(\.horizontalSizeClass) private var horizontalSizeClass
	
	@State private var courses: [Course] = [
		Course(grade: .A, level: .regular),
		Course(grade: .A, level: .regular),
		Course(grade: .A, level: .regular),
		Course(grade: .A, level: .regular),
		Course(grade: .A, level: .regular),
		Course(grade: .A, level: .regular),
		Course(grade: .A, level: .regular)
	]
	
	private var unweightedGPA: Double {
		let total: Double = courses.map { $0.grade.rawValue }.reduce(0, +)
		return total / Double(courses.count)
	}
	
	private var weightedGPA: Double {
		let total = courses.map { $0.grade.rawValue + $0.level.rawValue }.reduce(0, +)
		return total / Double(courses.count)
	}
	
	private var navigationTitle: String {
		if horizontalSizeClass == .compact {
			"GPA"
		} else {
			"Grade Point Average"
		}
	}
	
	var body: some View {
		NavigationStack {
			Form {
				if horizontalSizeClass == .compact {
					Section(header: Text("Course Grades & Types")) {
						ForEach(courses.indices, id: \.self) { index in
							VStack(alignment: .leading) {
								Text("Course \(index + 1)")
									.fontWeight(.semibold)
								
								HStack(spacing: 32) {
									Picker("Grade", selection: $courses[index].grade) {
										ForEach(Grades.allCases) { grade in
											Text(grade.description).tag(grade)
										}
									}
									
									Picker("Type", selection: $courses[index].level) {
										ForEach(Levels.allCases) { level in
											Text(level.description).tag(level)
										}
									}
								}
							}
						}
					}
					
					Section(footer: Text("Regular courses are worth 4.0 points, Honors courses are worth 4.5 points, and G/T & AP courses are worth 5.0 points.")) {
						HStack {
							LabeledContent("Unweighted", value: unweightedGPA.formatted(.number.precision(.fractionLength(1...3))))
							
							LabeledContent("Weighted", value: weightedGPA.formatted(.number.precision(.fractionLength(1...3))))
						}
						.contextMenu {
							Button("Copy Unweighted", systemImage: "document.on.document") {
								Copy.copyToClipboard(unweightedGPA.formatted(.number.precision(.fractionLength(1...3))))
							}
							
							Button("Copy Weighted", systemImage: "document.on.document") {
								Copy.copyToClipboard(weightedGPA.formatted(.number.precision(.fractionLength(1...3))))
							}
						}
					}
				} else {
					Section(header: Text("Course Grades & Types")) {
						ForEach(courses.indices, id: \.self) { index in
							HStack {
								Text("Course \(index + 1)")
									.fontWeight(.semibold)
								
								Spacer()
							
								Picker("Grade", selection: $courses[index].grade) {
									ForEach(Grades.allCases) { grade in
										Text(grade.description).tag(grade)
									}
								}
								
								Picker("Type", selection: $courses[index].level) {
									ForEach(Levels.allCases) { level in
										Text(level.description).tag(level)
									}
								}
							}
						}
					}
					
					Section(footer: Text("Regular courses are worth 4.0 points, Honors courses are worth 4.5 points, and G/T & AP courses are worth 5.0 points.")) {
						#if os(macOS)
						HStack(spacing: 16) {
							CopyableRow(
								label: "Unweighted GPA",
								value: String(unweightedGPA.formatted(.number.precision(.fractionLength(1...3))))
							)
							
							CopyableRow(
								label: "Weighted GPA",
								value: String(weightedGPA.formatted(.number.precision(.fractionLength(1...3))))
							)
						}
						#else
						HStack {
							LabeledContent("Unweighted", value: unweightedGPA.formatted(.number.precision(.fractionLength(1...3))))
							
							LabeledContent("Weighted", value: weightedGPA.formatted(.number.precision(.fractionLength(1...3))))
						}
						.contextMenu {
							Button("Copy Unweighted", systemImage: "document.on.document") {
								Copy.copyToClipboard(unweightedGPA.formatted(.number.precision(.fractionLength(1...3))))
							}
							
							Button("Copy Weighted", systemImage: "document.on.document") {
								Copy.copyToClipboard(weightedGPA.formatted(.number.precision(.fractionLength(1...3))))
							}
						}
						#endif
					}
				}
			}
			.formStyle(.grouped)
			.navigationTitle(navigationTitle)
			.toolbarTitleDisplayMode(.inlineLarge)
			.toolbar {
				ToolbarItem(placement: .primaryAction) {
					Button("Reset", systemImage: "arrow.counterclockwise") {
						courses.indices.forEach( { courses[$0].grade = .A } )
						courses.indices.forEach( { courses[$0].level = .regular } )
					}
				}
			}
		}
	}
}

#Preview {
	GPAView()
}
