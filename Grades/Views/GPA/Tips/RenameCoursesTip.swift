//
//  RenameCoursesTip.swift
//  Grades
//
//  Created by Aram Soneson on 8/5/26.
//

import SwiftUI
import TipKit

struct RenameCoursesTip: Tip {
	var title: Text {
		Text("Rename Courses")
	}
	var message: Text? {
		Text("Tap any course's name to edit it.")
	}
	var image: Image? {
		Image(systemName: "character.cursor.ibeam")
	}
}
