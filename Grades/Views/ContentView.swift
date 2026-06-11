//
//  ContentView.swift
//  Grades
//
//  Created by Aram Soneson on 1/20/26.
//

import SwiftUI

struct ContentView: View {
	@Environment(\.horizontalSizeClass) private var horizontalSizeClass
	
	@State private var selectedTab: TabSelection = .fullYear
	
	private var stateAssessedTabDisplayName: String {
		if horizontalSizeClass == .compact {
			"State"
		} else {
			"State-Assessed"
		}
	}
	
	var body: some View {
		TabView(selection: $selectedTab) {
			Tab("Full Year", systemImage: "calendar", value: .fullYear) {
				FullYearView()
			}
			
			Tab("Semester", systemImage: "circle.lefthalf.striped.horizontal", value: .semester) {
				SemesterView()
			}
			
			Tab(stateAssessedTabDisplayName, systemImage: "mappin.and.ellipse", value: .stateAssessed) {
				StateAssessedView()
			}
			
			Tab("GPA", systemImage: "rosette", value: .gpa) {
				GPAView()
			}
		}
	}
}

#Preview {
	ContentView()
}
