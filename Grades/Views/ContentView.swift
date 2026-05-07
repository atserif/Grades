//
//  ContentView.swift
//  Grades
//
//  Created by Aram Soneson on 1/20/26.
//

import SwiftUI

struct ContentView: View {
	@Environment(\.horizontalSizeClass) private var horizontalSizeClass
	
	private var stateAssessedTabDisplayName: String {
		if horizontalSizeClass == .compact {
			"State"
		} else {
			"State-Assessed"
		}
	}
	
	var body: some View {
		TabView {
			Tab("Full Year", systemImage: "calendar") {
				FullYearView()
			}
			Tab("Semester", systemImage: "calendar.badge.clock") {
				SemesterView()
			}
			Tab(stateAssessedTabDisplayName, systemImage: "mappin.and.ellipse") {
				StateAssessedView()
			}
			Tab("GPA", systemImage: "rosette") {
				GPAView()
			}
		}
	}
}

#Preview {
	ContentView()
}
