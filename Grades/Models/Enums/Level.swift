//
//  Levels.swift
//  Grades
//
//  Created by Aram Soneson on 6/1/26.
//

import SwiftUI

enum Level: Double, CaseIterable {
	case regular = 0
	case honors = 0.5
	case gtap = 1
	
	var description: LocalizedStringKey {
		switch self {
		case .regular: "Regular"
		case .honors: "Honors"
		case .gtap: "G/T · AP"
		}
	}
}
