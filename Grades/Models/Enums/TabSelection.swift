//
//  TabSelection.swift
//  Grades
//
//  Created by Aram Soneson on 6/11/26.
//

enum TabSelection: String, CaseIterable, Identifiable, CustomStringConvertible {
	case fullYear = "Full Year"
	case semester = "Semester"
	case stateAssessed = "State-Assessed"
	case gpa = "GPA"
	
	var id: String { rawValue }
	
	var description: String {
		switch self {
		case .fullYear: "calendar"
		case .semester: "circle.lefthalf.striped.horizontal"
		case .stateAssessed: "mappin.and.ellipse"
		case .gpa: "rosette"
		}
	}
}
