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
	@Binding var editState: EditMode
	
	var focused: FocusState<UUID?>.Binding
	
	var body: some View {
		VStack(alignment: .leading) {
			TextField("New Course", text: $course.name, prompt: Text("New Course"))
				.padding(.horizontal)
				.focused(focused, equals: course.id)
				.bold()
				.submitLabel(.done)
				.autocorrectionDisabled()
				.textInputAutocapitalization(.words)
				.writingToolsBehavior(.disabled)
				.writingToolsAffordanceVisibility(.hidden)
			
			ScrollView(.horizontal) {
				HStack(spacing: 12) {
					Menu(course.grade.description, systemImage: "checkmark.circle") {
						Picker("Grade", selection: $course.grade) {
							ForEach(Grade.allCases, id: \.self) { grade in
								Text(grade.description)
									.tag(grade)
							}
						}
						.labelsVisibility(.visible)
					}
					.animation(.default, value: course.level)
					.animation(.default, value: course.credits)
					
					Menu(course.level.description, systemImage: "square.3.layers.3d") {
						Picker("Level", selection: $course.level) {
							ForEach(Level.allCases, id: \.self) { level in
								Text(level.description)
									.tag(level)
							}
						}
						.labelsVisibility(.visible)
					}
					.animation(.default, value: course.grade)
					.animation(.default, value: course.credits)
					
					Menu(course.credits.description, systemImage: "scalemass") {
						Picker("Credits", selection: $course.credits) {
							ForEach(credits, id: \.self) { credits in
								Text(String(credits))
									.tag(credits)
							}
						}
						.labelsVisibility(.visible)
					}
					.animation(.default, value: course.grade)
					.animation(.default, value: course.level)
				}
				.padding(.horizontal)
				.labelStyle(.simple)
			}
			.scrollIndicators(.hidden)
			.scrollBounceBehavior(.basedOnSize, axes: .horizontal)
			.mask {
				HStack(spacing: 0) {
					if editState != .inactive {
						LinearGradient(gradient: Gradient(colors: [.clear, .black]), startPoint: .leading, endPoint: .trailing)
							.frame(width: 16)
						
						Rectangle()
							.fill(.black)
						
						LinearGradient(gradient: Gradient(colors: [.black, .clear]), startPoint: .leading, endPoint: .trailing)
							.frame(width: 16)
					} else {
						Rectangle()
							.fill(.black)
					}
				}
			}
			.animation(.default, value: editState)
		}
		.listRowInsets(EdgeInsets(top: 16, leading: 0, bottom: 16, trailing: 0))
	}
}

#Preview {
	GPAView()
}
