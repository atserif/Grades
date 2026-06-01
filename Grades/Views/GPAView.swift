//
//  GPAView.swift
//  Grades
//
//  Created by Aram Soneson on 1/20/26.
//

import SwiftUI

struct GPAView: View {
	@Environment(\.horizontalSizeClass) private var horizontalSizeClass
	
	@State private var weightedCopyButtonHovered = false
	@State private var weightedCopyButtonClicked = false
	@State private var unweightedCopyButtonHovered = false
	@State private var unweightedCopyButtonClicked = false
	
	private var navigationTitle: String {
		if horizontalSizeClass == .compact {
			"GPA"
		} else {
			"Grade Point Average"
		}
	}
	
	@State private var course1Grade: Grades = .A
	@State private var course2Grade: Grades = .A
	@State private var course3Grade: Grades = .A
	@State private var course4Grade: Grades = .A
	@State private var course5Grade: Grades = .A
	@State private var course6Grade: Grades = .A
	@State private var course7Grade: Grades = .A
	
	@State private var course1Level: Levels = .regular
	@State private var course2Level: Levels = .regular
	@State private var course3Level: Levels = .regular
	@State private var course4Level: Levels = .regular
	@State private var course5Level: Levels = .regular
	@State private var course6Level: Levels = .regular
	@State private var course7Level: Levels = .regular
	
	private var unweightedGPA: Double {
		Double(course1Grade.rawValue + course2Grade.rawValue + course3Grade.rawValue + course4Grade.rawValue + course5Grade.rawValue + course7Grade.rawValue + course7Grade.rawValue) / 7
	}
	
	private var weightedGPA: Double {
		let course1Value: Double
		let course2Value: Double
		let course3Value: Double
		let course4Value: Double
		let course5Value: Double
		let course6Value: Double
		let course7Value: Double
		
		switch course1Level {
		case .regular:
			course1Value = Double(course1Grade.rawValue)
		case .honors:
			course1Value = Double(course1Grade.rawValue) + 0.5
		case .gtap:
			course1Value = Double(course1Grade.rawValue + 1)
		}
		
		switch course2Level {
		case .regular:
			course2Value = Double(course2Grade.rawValue)
		case .honors:
			course2Value = Double(course2Grade.rawValue) + 0.5
		case .gtap:
			course2Value = Double(course2Grade.rawValue + 1)
		}
		
		switch course2Level {
		case .regular:
			course3Value = Double(course3Grade.rawValue)
		case .honors:
			course3Value = Double(course3Grade.rawValue) + 0.5
		case .gtap:
			course3Value = Double(course3Grade.rawValue + 1)
		}
		
		switch course4Level {
		case .regular:
			course4Value = Double(course4Grade.rawValue)
		case .honors:
			course4Value = Double(course4Grade.rawValue) + 0.5
		case .gtap:
			course4Value = Double(course4Grade.rawValue + 1)
		}
		
		switch course5Level {
		case .regular:
			course5Value = Double(course5Grade.rawValue)
		case .honors:
			course5Value = Double(course5Grade.rawValue) + 0.5
		case .gtap:
			course5Value = Double(course5Grade.rawValue + 1)
		}
		
		switch course6Level {
		case .regular:
			course6Value = Double(course6Grade.rawValue)
		case .honors:
			course6Value = Double(course6Grade.rawValue) + 0.5
		case .gtap:
			course6Value = Double(course6Grade.rawValue + 1)
		}
		
		switch course7Level {
		case .regular:
			course7Value = Double(course7Grade.rawValue)
		case .honors:
			course7Value = Double(course7Grade.rawValue) + 0.5
		case .gtap:
			course7Value = Double(course7Grade.rawValue + 1)
		}
		
		let finalValue: Double = (course1Value + course2Value + course3Value + course4Value + course5Value + course6Value + course7Value) / 7
		
		return finalValue
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
								Picker("Grade", selection: $course1Grade) {
									ForEach(Grades.allCases) { grade in
										Text(grade.description).tag(grade)
									}
								}
								
								Picker("Type", selection: $course1Level) {
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
								Picker("Grade", selection: $course2Grade) {
									ForEach(Grades.allCases) { grade in
										Text(grade.description).tag(grade)
									}
								}
								
								Picker("Type", selection: $course2Level) {
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
								Picker("Grade", selection: $course3Grade) {
									ForEach(Grades.allCases) { grade in
										Text(grade.description).tag(grade)
									}
								}
								
								Picker("Type", selection: $course3Level) {
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
								Picker("Grade", selection: $course4Grade) {
									ForEach(Grades.allCases) { grade in
										Text(grade.description).tag(grade)
									}
								}
								
								Picker("Type", selection: $course4Level) {
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
								Picker("Grade", selection: $course5Grade) {
									ForEach(Grades.allCases) { grade in
										Text(grade.description).tag(grade)
									}
								}
								
								Picker("Type", selection: $course5Level) {
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
								Picker("Grade", selection: $course6Grade) {
									ForEach(Grades.allCases) { grade in
										Text(grade.description).tag(grade)
									}
								}
								
								Picker("Type", selection: $course6Level) {
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
								Picker("Grade", selection: $course7Grade) {
									ForEach(Grades.allCases) { grade in
										Text(grade.description).tag(grade)
									}
								}
								
								Picker("Type", selection: $course7Level) {
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
								Picker("Grade", selection: $course1Grade) {
									ForEach(Grades.allCases) { grade in
										Text(grade.description).tag(grade)
									}
								}
								
								Picker("Type", selection: $course1Level) {
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
								Picker("Grade", selection: $course2Grade) {
									ForEach(Grades.allCases) { grade in
										Text(grade.description).tag(grade)
									}
								}
								
								Picker("Type", selection: $course2Level) {
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
								Picker("Grade", selection: $course3Grade) {
									ForEach(Grades.allCases) { grade in
										Text(grade.description).tag(grade)
									}
								}
								
								Picker("Type", selection: $course3Level) {
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
								Picker("Grade", selection: $course4Grade) {
									ForEach(Grades.allCases) { grade in
										Text(grade.description).tag(grade)
									}
								}
								
								Picker("Type", selection: $course4Level) {
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
								Picker("Grade", selection: $course5Grade) {
									ForEach(Grades.allCases) { grade in
										Text(grade.description).tag(grade)
									}
								}
								
								Picker("Type", selection: $course5Level) {
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
								Picker("Grade", selection: $course6Grade) {
									ForEach(Grades.allCases) { grade in
										Text(grade.description).tag(grade)
									}
								}
								
								Picker("Type", selection: $course6Level) {
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
								Picker("Grade", selection: $course7Grade) {
									ForEach(Grades.allCases) { grade in
										Text(grade.description).tag(grade)
									}
								}
								
								Picker("Type", selection: $course7Level) {
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
						course1Grade = .A
						course2Grade = .A
						course3Grade = .A
						course4Grade = .A
						course5Grade = .A
						course6Grade = .A
						course7Grade = .A
						
						course1Level = .regular
						course2Level = .regular
						course3Level = .regular
						course4Level = .regular
						course5Level = .regular
						course6Level = .regular
						course7Level = .regular
					}
				}
			}
		}
	}
}

#Preview {
	GPAView()
}
