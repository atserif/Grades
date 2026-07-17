//
//  GPARow.swift
//  Grades
//
//  Created by Aram Soneson on 7/7/26.
//

import SwiftUI

struct GPARow: View {
	@Binding var course: Course
	
	var focused: FocusState<UUID?>.Binding
	
	var body: some View {
		TextField("New Course", text: $course.name, prompt: Text("New Course"))
			.focused(focused, equals: course.id)
			.bold()
			.submitLabel(.done)
			.autocorrectionDisabled()
			.labelsHidden()
			.writingToolsBehavior(.disabled)
			.writingToolsAffordanceVisibility(.hidden)
		
		HStack(spacing: 16) {
			Picker("Grade", selection: $course.grade) {
				ForEach(Grade.allCases, id: \.self) { grade in
					Text(grade.description)
						.tag(grade)
				}
			}
			
			Picker("Level", selection: $course.level) {
				ForEach(Level.allCases, id: \.self) { level in
					Text(level.description)
						.tag(level)
				}
			}
		}
		.pickerStyle(.menu)
		.tint(.secondary)
	}
}

#Preview {
	GPAView()
}
