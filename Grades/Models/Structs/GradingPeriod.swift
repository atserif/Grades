//
//  GradingPeriod.swift
//  Grades
//
//  Created by Aram Soneson on 6/5/26.
//

struct GradingPeriod: Codable {
	let name: String
	let type: `Type`
	var grade: Grade
}
