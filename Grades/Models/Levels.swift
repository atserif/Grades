//
//  Levels.swift
//  Grades
//
//  Created by Aram Soneson on 6/1/26.
//

enum Levels: Double, CaseIterable, Identifiable, CustomStringConvertible {
	case regular = 0
	case honors = 0.5
	case gtap = 1
	
	var id: Double { rawValue }
	
	var description: String {
		switch self {
		case .regular: "Regular"
		case .honors: "Honors"
		case .gtap: "G/T · AP"
		}
	}
}
