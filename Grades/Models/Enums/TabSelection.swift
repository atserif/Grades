//
//  TabSelection.swift
//  Grades
//
//  Created by Aram Soneson on 6/11/26.
//

import SwiftUI

enum TabSelection: String, CaseIterable, Identifiable {
	case fullYear = "Full Year"
	case semester = "Semester"
	case stateAssessed = "State"
	case gpa = "GPA"
	
	var id: String { rawValue }
	
	var symbol: String {
		switch self {
		case .fullYear: "calendar"
		case .semester: "circle.lefthalf.striped.horizontal"
		case .stateAssessed: "mappin.and.ellipse"
		case .gpa: "rosette"
		}
	}
	
	var view: any View {
		switch self {
		case .fullYear: FullYearView()
		case .semester: SemesterView()
		case .stateAssessed: StateAssessedView()
		case .gpa: GPAView()
		}
	}
}
