//
//  SemesterView.swift
//  Grades
//
//  Created by Aram Soneson on 1/20/26.
//

import SwiftUI

struct SemesterView: View {
	@Environment(\.horizontalSizeClass) private var horizontalSizeClass
	
	@State private var copyButtonHovered = false
	@State private var copyButtonClicked = false
	
	private var navigationTitle: String {
		if horizontalSizeClass == .compact {
			"Semester"
		} else {
			"Semester Courses"
		}
	}
	
	@State private var q1Grade = "A"
	@State private var q2Grade = "A"
	@State private var finalGrade = "A"
	
	private let grades = ["A", "B", "C", "D", "E"]
	
	private var courseGrade: String {
		var q1Value = 0
		var q2Value = 0
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
		
		let weightedTotalValue = (q1Value + q2Value) * 2 + finalValue
		
		let averageValue = Double(weightedTotalValue) / 5
		
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
					
					Picker("Final", selection: $finalGrade) {
						ForEach(grades, id: \.self) {
							Text($0)
						}
					}
				}
				
				Section(footer: Text("Each quarter grade is worth 40%. The final exam is worth 20%.")) {
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
						finalGrade = "A"
					}
				}
			}
		}
	}
}

#Preview {
	SemesterView()
}
