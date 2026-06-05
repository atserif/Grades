//
//  GPAView.swift
//  Grades
//
//  Created by Aram Soneson on 1/20/26.
//

import SwiftUI

struct GPAView: View {
	@Environment(\.horizontalSizeClass) private var horizontalSizeClass
	
	@State private var weightedCopyButtonHovered: Bool = false
	@State private var weightedCopyButtonClicked: Bool = false
	@State private var unweightedCopyButtonHovered: Bool = false
	@State private var unweightedCopyButtonClicked: Bool = false
	
	@State private var courses: [Course] = [
		Course(grade: .A, level: .regular),
		Course(grade: .A, level: .regular),
		Course(grade: .A, level: .regular),
		Course(grade: .A, level: .regular),
		Course(grade: .A, level: .regular),
		Course(grade: .A, level: .regular),
		Course(grade: .A, level: .regular)
	]
	
	private var unweightedGPA: Double {
		let total: Double = courses.map { $0.grade.rawValue }.reduce(0, +)
		return total / Double(courses.count)
	}
	
	private var weightedGPA: Double {
		let total = courses.map { $0.grade.rawValue + $0.level.rawValue }.reduce(0, +)
		return total / Double(courses.count)
	}
	
	private var navigationTitle: String {
		if horizontalSizeClass == .compact {
			"GPA"
		} else {
			"Grade Point Average"
		}
	}
	
	var body: some View {
		NavigationStack {
			Form {
				if horizontalSizeClass == .compact {
					Section(header: Text("Course Grades & Types")) {
						VStack(alignment: .leading) {
							Text("Course 1")
								.fontWeight(.semibold)
							
							HStack(spacing: 32) {
								Picker("Grade", selection: $courses[0].grade) {
									ForEach(Grades.allCases) { grade in
										Text(grade.description).tag(grade)
									}
								}
								
								Picker("Type", selection: $courses[0].level) {
									ForEach(Levels.allCases) { level in
										Text(level.description).tag(level)
									}
								}
							}
						}
						
						VStack(alignment: .leading) {
							Text("Course 2")
								.fontWeight(.semibold)
							
							HStack(spacing: 32) {
								Picker("Grade", selection: $courses[1].grade) {
									ForEach(Grades.allCases) { grade in
										Text(grade.description).tag(grade)
									}
								}
								
								Picker("Type", selection: $courses[1].level) {
									ForEach(Levels.allCases) { level in
										Text(level.description).tag(level)
									}
								}
							}
						}
						
						VStack(alignment: .leading) {
							Text("Course 3")
								.fontWeight(.semibold)
							
							HStack(spacing: 32) {
								Picker("Grade", selection: $courses[2].grade) {
									ForEach(Grades.allCases) { grade in
										Text(grade.description).tag(grade)
									}
								}
								
								Picker("Type", selection: $courses[2].level) {
									ForEach(Levels.allCases) { level in
										Text(level.description).tag(level)
									}
								}
							}
						}
						
						VStack(alignment: .leading) {
							Text("Course 4")
								.fontWeight(.semibold)
							
							HStack(spacing: 32) {
								Picker("Grade", selection: $courses[3].grade) {
									ForEach(Grades.allCases) { grade in
										Text(grade.description).tag(grade)
									}
								}
								
								Picker("Type", selection: $courses[3].level) {
									ForEach(Levels.allCases) { level in
										Text(level.description).tag(level)
									}
								}
							}
						}
						
						VStack(alignment: .leading) {
							Text("Course 5")
								.fontWeight(.semibold)
							
							HStack(spacing: 32) {
								Picker("Grade", selection: $courses[4].grade) {
									ForEach(Grades.allCases) { grade in
										Text(grade.description).tag(grade)
									}
								}
								
								Picker("Type", selection: $courses[4].level) {
									ForEach(Levels.allCases) { level in
										Text(level.description).tag(level)
									}
								}
							}
						}
						
						VStack(alignment: .leading) {
							Text("Course 6")
								.fontWeight(.semibold)
							
							HStack(spacing: 32) {
								Picker("Grade", selection: $courses[5].grade) {
									ForEach(Grades.allCases) { grade in
										Text(grade.description).tag(grade)
									}
								}
								
								Picker("Type", selection: $courses[5].level) {
									ForEach(Levels.allCases) { level in
										Text(level.description).tag(level)
									}
								}
							}
						}
						
						VStack(alignment: .leading) {
							Text("Course 7")
								.fontWeight(.semibold)
							
							HStack(spacing: 32) {
								Picker("Grade", selection: $courses[6].grade) {
									ForEach(Grades.allCases) { grade in
										Text(grade.description).tag(grade)
									}
								}
								
								Picker("Type", selection: $courses[6].level) {
									ForEach(Levels.allCases) { level in
										Text(level.description).tag(level)
									}
								}
							}
						}
					}
					
					Section(footer: Text("Regular courses are worth 4.0 points, Honors courses are worth 4.5 points, and G/T & AP courses are worth 5.0 points.")) {
						HStack(spacing: 32) {
							LabeledContent("Weighted", value: weightedGPA.formatted(.number.precision(.fractionLength(1...3))))
							
							LabeledContent("Unweighted", value: unweightedGPA.formatted(.number.precision(.fractionLength(1...3))))
						}
						.contextMenu {
							Button("Copy Weighted", systemImage: "document.on.document") {
								Copy.copyToClipboard(weightedGPA.formatted(.number.precision(.fractionLength(1...3))))
							}
							
							Button("Copy Unweighted", systemImage: "document.on.document") {
								Copy.copyToClipboard(unweightedGPA.formatted(.number.precision(.fractionLength(1...3))))
							}
						}
					}
				} else {
					Section(header: Text("Course Grades & Types")) {
						HStack {
							HStack {
								Text("Course 1")
									.fontWeight(.semibold)
								
								Spacer()
							}
							
							HStack {
								Picker("Grade", selection: $courses[0].grade) {
									ForEach(Grades.allCases) { grade in
										Text(grade.description).tag(grade)
									}
								}
								
								Picker("Type", selection: $courses[0].level) {
									ForEach(Levels.allCases) { level in
										Text(level.description).tag(level)
									}
								}
							}
						}
						
						HStack {
							HStack {
								Text("Course 2")
									.fontWeight(.semibold)
								
								Spacer()
							}
							
							HStack {
								Picker("Grade", selection: $courses[1].grade) {
									ForEach(Grades.allCases) { grade in
										Text(grade.description).tag(grade)
									}
								}
								
								Picker("Type", selection: $courses[1].level) {
									ForEach(Levels.allCases) { level in
										Text(level.description).tag(level)
									}
								}
							}
						}
						
						HStack {
							HStack {
								Text("Course 3")
									.fontWeight(.semibold)
								
								Spacer()
							}
							
							HStack {
								Picker("Grade", selection: $courses[2].grade) {
									ForEach(Grades.allCases) { grade in
										Text(grade.description).tag(grade)
									}
								}
								
								Picker("Type", selection: $courses[2].level) {
									ForEach(Levels.allCases) { level in
										Text(level.description).tag(level)
									}
								}
							}
						}
						
						HStack {
							HStack {
								Text("Course 4")
									.fontWeight(.semibold)
								
								Spacer()
							}
							
							HStack {
								Picker("Grade", selection: $courses[3].grade) {
									ForEach(Grades.allCases) { grade in
										Text(grade.description).tag(grade)
									}
								}
								
								Picker("Type", selection: $courses[3].level) {
									ForEach(Levels.allCases) { level in
										Text(level.description).tag(level)
									}
								}
							}
						}
						
						HStack {
							HStack {
								Text("Course 5")
									.fontWeight(.semibold)
								
								Spacer()
							}
							
							HStack {
								Picker("Grade", selection: $courses[4].grade) {
									ForEach(Grades.allCases) { grade in
										Text(grade.description).tag(grade)
									}
								}
								
								Picker("Type", selection: $courses[4].level) {
									ForEach(Levels.allCases) { level in
										Text(level.description).tag(level)
									}
								}
							}
						}
						
						HStack {
							HStack {
								Text("Course 6")
									.fontWeight(.semibold)
								
								Spacer()
							}
							
							HStack {
								Picker("Grade", selection: $courses[5].grade) {
									ForEach(Grades.allCases) { grade in
										Text(grade.description).tag(grade)
									}
								}
								
								Picker("Type", selection: $courses[5].level) {
									ForEach(Levels.allCases) { level in
										Text(level.description).tag(level)
									}
								}
							}
						}
						
						HStack {
							HStack {
								Text("Course 7")
									.fontWeight(.semibold)
								
								Spacer()
							}
							
							HStack {
								Picker("Grade", selection: $courses[6].grade) {
									ForEach(Grades.allCases) { grade in
										Text(grade.description).tag(grade)
									}
								}
								
								Picker("Type", selection: $courses[6].level) {
									ForEach(Levels.allCases) { level in
										Text(level.description).tag(level)
									}
								}
							}
						}
					}
					Section(footer: Text("Regular courses are worth 4.0 points, Honors courses are worth 4.5 points, and G/T & AP courses are worth 5.0 points.")) {
						#if os(macOS)
						HStack(spacing: 16) {
							HStack {
								Text("Weighted GPA")
								
								Spacer()
								
								Button {
									if !weightedCopyButtonClicked {
										withAnimation(.spring(duration: 0.4)) {
											Copy.copyToClipboard(weightedGPA.formatted(.number.precision(.fractionLength(1...3))))
											weightedCopyButtonClicked = true
										}
										
										DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
											withAnimation(.spring(duration: 0.4)) {
												weightedCopyButtonClicked = false
											}
										}
									}
								} label: {
									if weightedCopyButtonClicked {
										HStack(spacing: 4) {
											Image(systemName: "document.on.document.fill")
												.padding(.vertical, -4)
											
											Text("Copied")
										}
										.padding(7)
										.background(weightedCopyButtonHovered ? Color(.tertiarySystemFill) : .clear)
										.foregroundStyle(.secondary)
										.clipShape(.rect(cornerRadius: 9))
										.transition(.scale(scale: 0.8).combined(with: .opacity))
										.onHover { hovered in
											weightedCopyButtonHovered = hovered
										}
									} else {
										Text(weightedGPA.formatted(.number.precision(.fractionLength(1...3))))
											.padding(5)
											.background(weightedCopyButtonHovered ? Color(.tertiarySystemFill) : .clear)
											.foregroundStyle(.secondary)
											.clipShape(.rect(cornerRadius: 7))
											.transition(.scale(scale: 0.8).combined(with: .opacity))
											.onHover { hovered in
												weightedCopyButtonHovered = hovered
											}
									}
								}
								.buttonStyle(UnresponsiveButtonStyle())
								.offset(x: weightedCopyButtonClicked ? 0 : -2)
								.padding(-7)
							}
							
							HStack {
								Text("Unweighted GPA")
								
								Spacer()
								
								Button {
									if !unweightedCopyButtonClicked {
										withAnimation(.spring(duration: 0.4)) {
											Copy.copyToClipboard(unweightedGPA.formatted(.number.precision(.fractionLength(1...3))))
											unweightedCopyButtonClicked = true
										}
										
										DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
											withAnimation(.spring(duration: 0.4)) {
												unweightedCopyButtonClicked = false
											}
										}
									}
								} label: {
									if unweightedCopyButtonClicked {
										HStack(spacing: 4) {
											Image(systemName: "document.on.document.fill")
												.padding(.vertical, -4)
											
											Text("Copied")
										}
										.padding(7)
										.background(unweightedCopyButtonHovered ? Color(.tertiarySystemFill) : .clear)
										.foregroundStyle(.secondary)
										.clipShape(.rect(cornerRadius: 9))
										.transition(.scale(scale: 0.8).combined(with: .opacity))
										.onHover { hovered in
											unweightedCopyButtonHovered = hovered
										}
									} else {
										Text(unweightedGPA.formatted(.number.precision(.fractionLength(1...3))))
											.padding(5)
											.background(unweightedCopyButtonHovered ? Color(.tertiarySystemFill) : .clear)
											.foregroundStyle(.secondary)
											.clipShape(.rect(cornerRadius: 7))
											.transition(.scale(scale: 0.8).combined(with: .opacity))
											.onHover { hovered in
												unweightedCopyButtonHovered = hovered
											}
									}
								}
								.buttonStyle(UnresponsiveButtonStyle())
								.offset(x: unweightedCopyButtonClicked ? 0 : -2)
								.padding(-7)
							}
						}
						#else
						HStack {
							LabeledContent("Weighted", value: weightedGPA.formatted(.number.precision(.fractionLength(1...3))))
							
							LabeledContent("Unweighted", value: unweightedGPA.formatted(.number.precision(.fractionLength(1...3))))
						}
						.contextMenu {
							Button("Copy Weighted", systemImage: "document.on.document") {
								Copy.copyToClipboard(weightedGPA.formatted(.number.precision(.fractionLength(1...3))))
							}
							
							Button("Copy Unweighted", systemImage: "document.on.document") {
								Copy.copyToClipboard(unweightedGPA.formatted(.number.precision(.fractionLength(1...3))))
							}
						}
						#endif
					}
				}
			}
			.formStyle(.grouped)
			.navigationTitle(navigationTitle)
			.toolbarTitleDisplayMode(.inlineLarge)
			.toolbar {
				ToolbarItem(placement: .primaryAction) {
					Button("Reset", systemImage: "arrow.counterclockwise") {
						courses.indices.forEach( { courses[$0].grade = .A } )
						courses.indices.forEach( { courses[$0].level = .regular } )
					}
				}
			}
		}
	}
}

#Preview {
	GPAView()
}
