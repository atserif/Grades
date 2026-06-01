//
//  FullYearView.swift
//  Grades
//
//  Created by Aram Soneson on 1/20/26.
//

import SwiftUI

struct FullYearView: View {
	@Environment(\.horizontalSizeClass) private var horizontalSizeClass
	
	@State private var q1Grade: Grades = .A
	@State private var q2Grade: Grades = .A
	@State private var midtermGrade: Grades = .A
	@State private var q3Grade: Grades = .A
	@State private var q4Grade: Grades = .A
	@State private var finalGrade: Grades = .A
	
	@State private var copyButtonHovered = false
	@State private var copyButtonClicked = false
	
	private var courseGrade: Grades {
		var letterGrade: Grades
		
		let weightedTotalValue = (q1Grade.rawValue + q2Grade.rawValue + q3Grade.rawValue + q4Grade.rawValue) * 2 + midtermGrade.rawValue + finalGrade.rawValue
		
		let averageValue = Double(weightedTotalValue) / 10
		
		switch averageValue {
		case 3.5...:
			letterGrade = .A
		case 2.5..<3.5:
			letterGrade = .B
		case 1.5..<2.5:
			letterGrade = .C
		case 0.75..<1.5:
			letterGrade = .D
		default:
			letterGrade = .E
		}
		
		return letterGrade
	}
	
	private var navigationTitle: String {
		if horizontalSizeClass == .compact {
			"Full Year"
		} else {
			"Full Year Courses"
		}
	}
	
	var body: some View {
		NavigationStack {
			Form {
				Section(header: Text("Quarter & Exam Grades")) {
					Picker("Quarter 1", selection: $q1Grade) {
						ForEach(Grades.allCases) { grade in
							Text(grade.description).tag(grade)
						}
					}
					
					Picker("Quarter 2", selection: $q2Grade) {
						ForEach(Grades.allCases) { grade in
							Text(grade.description).tag(grade)
						}
					}
					
					Picker("Midterm", selection: $midtermGrade) {
						ForEach(Grades.allCases) { grade in
							Text(grade.description).tag(grade)
						}
					}
					
					Picker("Quarter 3", selection: $q3Grade) {
						ForEach(Grades.allCases) { grade in
							Text(grade.description).tag(grade)
						}
					}
					
					Picker("Quarter 4", selection: $q4Grade) {
						ForEach(Grades.allCases) { grade in
							Text(grade.description).tag(grade)
						}
					}
					
					Picker("Final", selection: $finalGrade) {
						ForEach(Grades.allCases) { grade in
							Text(grade.description).tag(grade)
						}
					}
				}
				
				Section(footer: Text("Each quarter grade is worth 20%. The midterm and final exams are worth 10% each.")) {
					#if os(macOS)
					HStack {
						Text("Course Grade")
						
						Spacer()
						
						Button {
							if !copyButtonClicked {
								withAnimation(.spring(duration: 0.4)) {
									Copy.copyToClipboard(courseGrade.description)
									copyButtonClicked = true
								}
								
								DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
									withAnimation(.spring(duration: 0.4)) {
										copyButtonClicked = false
									}
								}
							}
						} label: {
							if copyButtonClicked {
								HStack(spacing: 4) {
									Image(systemName: "document.on.document.fill")
										.padding(.vertical, -4)
									
									Text("Copied")
								}
								.padding(7)
								.background(copyButtonHovered ? Color(.tertiarySystemFill) : .clear)
								.foregroundStyle(.secondary)
								.clipShape(.rect(cornerRadius: 9))
								.transition(.scale(scale: 0.8).combined(with: .opacity))
								.onHover { hovered in
									copyButtonHovered = hovered
								}
							} else {
								Text(courseGrade)
									.padding(5)
									.background(copyButtonHovered ? Color(.tertiarySystemFill) : .clear)
									.foregroundStyle(.secondary)
									.clipShape(.rect(cornerRadius: 7))
									.transition(.scale(scale: 0.8).combined(with: .opacity))
									.onHover { hovered in
										copyButtonHovered = hovered
									}
							}
						}
						.buttonStyle(UnresponsiveButtonStyle())
						.offset(x: copyButtonClicked ? 0 : -2)
						.padding(-7)
					}
					#else
					LabeledContent("Course Grade", value: courseGrade.description)
						.contextMenu {
							Button("Copy Course Grade", systemImage: "document.on.document") {
								Copy.copyToClipboard(courseGrade.description)
							}
						}
					#endif
				}
			}
			.formStyle(.grouped)
			.navigationTitle(navigationTitle)
			.toolbarTitleDisplayMode(.inlineLarge)
			.toolbar {
				ToolbarItem(placement: .primaryAction) {
					Button("Reset", systemImage: "arrow.counterclockwise") {
						q1Grade = .A
						q2Grade = .A
						midtermGrade = .A
						q3Grade = .A
						q4Grade = .A
						finalGrade = .A
					}
				}
			}
		}
	}
}

#Preview {
	FullYearView()
}
