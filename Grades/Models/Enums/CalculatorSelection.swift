//
//  CalculatorSelection.swift
//  Grades
//
//  Created by Aram Soneson on 7/12/26.
//

import SwiftUI

enum CalculatorSelection: CaseIterable {
	case fullYear
	case semester
	case stateAssessed
	
	var description: LocalizedStringKey {
		switch self {
		case .fullYear: "Full Year"
		case .semester: "Semester"
		case .stateAssessed: "State-Assessed"
		}
	}
}
