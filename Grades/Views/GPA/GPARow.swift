//
//  GPARow.swift
//  Grades
//
//  Created by Aram Soneson on 7/7/26.
//

import SwiftUI

struct GPARow: View {
	@State private var credits: [Double] = [1.0, 0.5, 0.25]
	
	@Binding var course: Course
	
	var focused: FocusState<UUID?>.Binding
	
	var body: some View {
		VStack(alignment: .leading) {
			TextField("New Course", text: $course.name, prompt: Text("New Course"))
				.focused(focused, equals: course.id)
				.bold()
				.submitLabel(.done)
				.autocorrectionDisabled()
				.textInputAutocapitalization(.words)
				.writingToolsBehavior(.disabled)
				.writingToolsAffordanceVisibility(.hidden)
			
			WrappingHStack(alignment: .leading, horizontalSpacing: 12) {
				Menu(course.grade.description, systemImage: "checkmark.circle") {
					Picker("Grade", selection: $course.grade) {
						ForEach(Grade.allCases, id: \.self) { grade in
							Text(grade.description)
								.tag(grade)
						}
					}
					.labelsVisibility(.visible)
				}
				
				Menu(course.level.description, systemImage: "square.3.layers.3d") {
					Picker("Level", selection: $course.level) {
						ForEach(Level.allCases, id: \.self) { level in
							Text(level.description)
								.tag(level)
						}
					}
					.labelsVisibility(.visible)
				}
				
				Menu(course.credits.description, systemImage: "scalemass") {
					Picker("Credits", selection: $course.credits) {
						ForEach(credits, id: \.self) { credits in
							Text(String(credits))
								.tag(credits)
						}
					}
					.labelsVisibility(.visible)
				}
			}
			.labelStyle(.simple)
		}
	}
}

#Preview {
	GPAView()
}
