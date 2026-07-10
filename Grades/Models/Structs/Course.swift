//
//  Course.swift
//  Grades
//
//  Created by Aram Soneson on 6/2/26.
//

import SwiftUI

struct Course: Identifiable, Equatable {
	let id = UUID()
	
	var name: String
	var grade: Grade
	var level: Level
}
