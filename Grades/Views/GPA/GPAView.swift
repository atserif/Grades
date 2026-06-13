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
					CompactGPAContent(courses: $courses, unweightedGPA: unweightedGPA, weightedGPA: weightedGPA)
				} else {
					RegularGPAContent(courses: $courses, unweightedGPA: unweightedGPA, weightedGPA: weightedGPA)
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
			.scrollEdgeEffectStyle(.soft, for: .top)
		}
	}
}

#Preview {
	ContentView()
}
