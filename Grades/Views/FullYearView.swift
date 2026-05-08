//
//  FullYearView.swift
//  Grades
//
//  Created by Aram Soneson on 1/20/26.
//

import SwiftUI

struct FullYearView: View {
	@Environment(\.horizontalSizeClass) private var horizontalSizeClass
	
	@State private var copyButtonHovered = false
	@State private var copyButtonClicked = false
	
	private var navigationTitle: String {
		if horizontalSizeClass == .compact {
			"Full Year"
		} else {
			"Full Year Courses"
		}
	}
	
	@State private var q1Grade = "A"
	@State private var q2Grade = "A"
	@State private var midtermGrade = "A"
	@State private var q3Grade = "A"
	@State private var q4Grade = "A"
	@State private var finalGrade = "A"
	
	private let grades = ["A", "B", "C", "D", "E"]
	
	private var courseGrade: String {
		var q1Value = 0
		var q2Value = 0
		var midtermValue = 0
		var q3Value = 0
		var q4Value = 0
		var finalValue = 0
		
		var letterGrade = "A"
		
		if q1Grade == "A" {
			q1Value = 4
		} else if q1Grade == "B" {
			q1Value = 3
		} else if q1Grade == "C" {
			q1Value = 2
		} else if q1Grade == "D" {
			q1Value = 1
		} else {
			q1Value = 0
		}
		
		if q2Grade == "A" {
			q2Value = 4
		} else if q2Grade == "B" {
			q2Value = 3
		} else if q2Grade == "C" {
			q2Value = 2
		} else if q2Grade == "D" {
			q2Value = 1
		} else {
			q2Value = 0
		}
		
		if midtermGrade == "A" {
			midtermValue = 4
		} else if midtermGrade == "B" {
			midtermValue = 3
		} else if midtermGrade == "C" {
			midtermValue = 2
		} else if midtermGrade == "D" {
			midtermValue = 1
		} else {
			midtermValue = 0
		}
		
		if q3Grade == "A" {
			q3Value = 4
		} else if q3Grade == "B" {
			q3Value = 3
		} else if q3Grade == "C" {
			q3Value = 2
		} else if q3Grade == "D" {
			q3Value = 1
		} else {
			q3Value = 0
		}
		
		if q4Grade == "A" {
			q4Value = 4
		} else if q4Grade == "B" {
			q4Value = 3
		} else if q4Grade == "C" {
			q4Value = 2
		} else if q4Grade == "D" {
			q4Value = 1
		} else {
			q4Value = 0
		}
		
		if finalGrade == "A" {
			finalValue = 4
		} else if finalGrade == "B" {
			finalValue = 3
		} else if finalGrade == "C" {
			finalValue = 2
		} else if finalGrade == "D" {
			finalValue = 1
		} else {
			finalValue = 0
		}
		
		let weightedTotalValue = (q1Value + q2Value + q3Value + q4Value) * 2 + midtermValue + finalValue
		
		let averageValue = Double(weightedTotalValue) / 10
		
		if averageValue >= 3.5 {
			letterGrade = "A"
		} else if averageValue >= 2.5 && averageValue < 3.5 {
			letterGrade = "B"
		} else if averageValue >= 1.5 && averageValue < 2.5 {
			letterGrade = "C"
		} else if averageValue >= 0.75 && averageValue < 1.5 {
			letterGrade = "D"
		} else {
			letterGrade = "E"
		}
		
		return letterGrade
	}
	
	var body: some View {
		NavigationStack {
			Form {
				Section(header: Text("Quarter & Exam Grades")) {
					Picker("Quarter 1", selection: $q1Grade) {
						ForEach(grades, id: \.self) {
							Text($0)
						}
					}
					
					Picker("Quarter 2", selection: $q2Grade) {
						ForEach(grades, id: \.self) {
							Text($0)
						}
					}
					
					Picker("Midterm", selection: $midtermGrade) {
						ForEach(grades, id: \.self) {
							Text($0)
						}
					}
					
					Picker("Quarter 3", selection: $q3Grade) {
						ForEach(grades, id: \.self) {
							Text($0)
						}
					}
					
					Picker("Quarter 4", selection: $q4Grade) {
						ForEach(grades, id: \.self) {
							Text($0)
						}
					}
					
					Picker("Final", selection: $finalGrade) {
						ForEach(grades, id: \.self) {
							Text($0)
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
									Copy.copyToClipboard(courseGrade)
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
					LabeledContent("Course Grade", value: courseGrade)
						.contextMenu {
							Button("Copy Course Grade", systemImage: "document.on.document") {
								Copy.copyToClipboard(courseGrade)
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
						q1Grade = "A"
						q2Grade = "A"
						midtermGrade = "A"
						q3Grade = "A"
						q4Grade = "A"
						finalGrade = "A"
					}
				}
			}
		}
	}
}

#Preview {
	FullYearView()
}
