//
//  StateAssessedView.swift
//  Grades
//
//  Created by Aram Soneson on 1/20/26.
//

import SwiftUI

struct StateAssessedView: View {
	@Environment(\.horizontalSizeClass) private var horizontalSizeClass

	@State private var copyButtonHovered: Bool = false
	@State private var copyButtonClicked: Bool = false
	
	@State private var q1Grade: Grades = .A
	@State private var q2Grade: Grades = .A
	@State private var q3Grade: Grades = .A
	@State private var q4Grade: Grades = .A
	@State private var assessmentGrade: Grades = .A
		
	private var courseGrade: Grades {
		var letterGrade: Grades
		
		let weightedTotal: Double = (q1Grade.rawValue + q2Grade.rawValue + q3Grade.rawValue + q4Grade.rawValue + assessmentGrade.rawValue) * 2
		let average: Double = weightedTotal / 10
		
		switch average {
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
			"State"
		} else {
			"State-Assessed Courses"
		}
	}
	
	var body: some View {
		NavigationStack {
			Form {
				Section(header: Text("Quarter & Assessment Grades")) {
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
					
					Picker("State Assessment", selection: $assessmentGrade) {
						ForEach(Grades.allCases) { grade in
							Text(grade.description).tag(grade)
						}
					}
				}
				Section(footer: Text("Quarter grades and the state assessment are each worth 20%. Applies to Biology, Biology G/T, American Government, and American Government Honors.")) {
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
								Text(courseGrade.description)
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
						q3Grade = .A
						q4Grade = .A
						assessmentGrade = .A
					}
				}
			}
		}
	}
}

#Preview {
	StateAssessedView()
}
