//
//  Layout.swift
//  Grades
//
//  Created by Aram Soneson on 6/15/26.
//

enum Layout: String, CaseIterable, Identifiable {
	case `default` = "Default"
	case reachable = "Reachable"
	
	var id: String { rawValue }
}
