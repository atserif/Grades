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
			.writingToolsBehavior(.disabled)
			.writingToolsAffordanceVisibility(.hidden)
		
		HStack(spacing: 8) {
			Menu(course.grade.description, systemImage: "checkmark.circle") {
				Picker("Grade", selection: $course.grade) {
					ForEach(Grade.allCases, id: \.self) { grade in
						Text(grade.description)
							.tag(grade)
					}
				}
			}
			
			Menu(course.level.description, systemImage: "square.3.layers.3d") {
				Picker("Level", selection: $course.level) {
					ForEach(Level.allCases, id: \.self) { level in
						Text(level.description)
							.tag(level)
					}
				}
			}
		}
		.labelStyle(.simple)
	}
}

#Preview {
	GPAView()
}
