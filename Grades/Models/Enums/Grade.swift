//
//  Grade.swift
//  Grades
//
//  Created by Aram Soneson on 6/1/26.
//

enum Grade: Double, CaseIterable {
	case A = 4
	case B = 3
	case C = 2
	case D = 1
	case E = 0
	
	var description: String {
		switch self {
		case .A: "A"
		case .B: "B"
		case .C: "C"
		case .D: "D"
		case .E: "E"
		}
	}
}
