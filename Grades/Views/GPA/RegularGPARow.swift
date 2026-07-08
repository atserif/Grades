//
//  RegularGPARow.swift
//  Grades
//
//  Created by Aram Soneson on 7/7/26.
//

import SwiftUI

struct RegularGPARow: View {
	@Binding var course: Course
	
	var focused: FocusState<UUID?>.Binding
	
    var body: some View {
		HStack(spacing: 16) {
			TextField("Course Name", text: $course.name, prompt: Text("Course Name"))
				.focused(focused, equals: $course.id)
				.fontWeight(.semibold)
				.submitLabel(.done)
				.autocorrectionDisabled()
				.labelsHidden()
				.writingToolsBehavior(.disabled)
				.writingToolsAffordanceVisibility(.hidden)
			
			HStack(spacing: 16) {
				Picker("Grade", selection: $course.grade) {
					ForEach(Grade.allCases, id: \.self) { grade in
						Text(grade.description).tag(grade)
					}
				}
				.pickerStyle(.menu)
				#if os(iOS)
				.tint(.secondary)
				#endif
				
				Picker("Type", selection: $course.level) {
					ForEach(Level.allCases, id: \.self) { level in
						Text(level.description).tag(level)
					}
				}
				.pickerStyle(.menu)
				#if os(iOS)
				.tint(.secondary)
				#endif
			}
		}
    }
}

#Preview {
    ContentView()
}
