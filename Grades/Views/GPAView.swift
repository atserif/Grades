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
	
	@State private var course1Grade = "A"
	@State private var course2Grade = "A"
	@State private var course3Grade = "A"
	@State private var course4Grade = "A"
	@State private var course5Grade = "A"
	@State private var course6Grade = "A"
	@State private var course7Grade = "A"
	@State private var course1Type = "Regular"
	@State private var course2Type = "Regular"
	@State private var course3Type = "Regular"
	@State private var course4Type = "Regular"
	@State private var course5Type = "Regular"
	@State private var course6Type = "Regular"
	@State private var course7Type = "Regular"
	
	private let grades = ["A", "B", "C", "D", "E"]
	private let types = ["Regular", "Honors", "G/T · AP"]
		
	private var unweightedGPA: Double {
		var course1Value: Double
		var course2Value: Double
		var course3Value: Double
		var course4Value: Double
		var course5Value: Double
		var course6Value: Double
		var course7Value: Double
		
		if course1Grade == "A" {
			course1Value = 4
		} else if course1Grade == "B" {
			course1Value = 3
		} else if course1Grade == "C" {
			course1Value = 2
		} else if course1Grade == "D" {
			course1Value = 1
		} else {
			course1Value = 0
		}
		
		if course2Grade == "A" {
			course2Value = 4
		} else if course2Grade == "B" {
			course2Value = 3
		} else if course2Grade == "C" {
			course2Value = 2
		} else if course2Grade == "D" {
			course2Value = 1
		} else {
			course2Value = 0
		}
		
		if course3Grade == "A" {
			course3Value = 4
		} else if course3Grade == "B" {
			course3Value = 3
		} else if course3Grade == "C" {
			course3Value = 2
		} else if course3Grade == "D" {
			course3Value = 1
		} else {
			course3Value = 0
		}
		
		if course4Grade == "A" {
			course4Value = 4
		} else if course4Grade == "B" {
			course4Value = 3
		} else if course4Grade == "C" {
			course4Value = 2
		} else if course4Grade == "D" {
			course4Value = 1
		} else {
			course4Value = 0
		}
		
		if course5Grade == "A" {
			course5Value = 4
		} else if course5Grade == "B" {
			course5Value = 3
		} else if course5Grade == "C" {
			course5Value = 2
		} else if course5Grade == "D" {
			course5Value = 1
		} else {
			course5Value = 0
		}
		
		if course6Grade == "A" {
			course6Value = 4
		} else if course6Grade == "B" {
			course6Value = 3
		} else if course6Grade == "C" {
			course6Value = 2
		} else if course6Grade == "D" {
			course6Value = 1
		} else {
			course6Value = 0
		}
		
		if course7Grade == "A" {
			course7Value = 4
		} else if course7Grade == "B" {
			course7Value = 3
		} else if course7Grade == "C" {
			course7Value = 2
		} else if course7Grade == "D" {
			course7Value = 1
		} else {
			course7Value = 0
		}
		
		let finalValue = (course1Value + course2Value + course3Value + course4Value + course5Value + course6Value + course7Value) / 7
		
		return finalValue
	}
	private var weightedGPA: Double {
		var course1Value: Double
		var course2Value: Double
		var course3Value: Double
		var course4Value: Double
		var course5Value: Double
		var course6Value: Double
		var course7Value: Double
		
		if course1Grade == "A" {
			course1Value = 4
		} else if course1Grade == "B" {
			course1Value = 3
		} else if course1Grade == "C" {
			course1Value = 2
		} else if course1Grade == "D" {
			course1Value = 1
		} else {
			course1Value = 0
		}
		
		if course1Type == "Honors" {
			course1Value += 0.5
		} else if course1Type == "G/T · AP" {
			course1Value += 1
		}
		
		if course2Grade == "A" {
			course2Value = 4
		} else if course2Grade == "B" {
			course2Value = 3
		} else if course2Grade == "C" {
			course2Value = 2
		} else if course2Grade == "D" {
			course2Value = 1
		} else {
			course2Value = 0
		}
		
		if course2Type == "Honors" {
			course2Value += 0.5
		} else if course2Type == "G/T · AP" {
			course2Value += 1
		}
		
		if course3Grade == "A" {
			course3Value = 4
		} else if course3Grade == "B" {
			course3Value = 3
		} else if course3Grade == "C" {
			course3Value = 2
		} else if course3Grade == "D" {
			course3Value = 1
		} else {
			course3Value = 0
		}
		
		if course3Type == "Honors" {
			course3Value += 0.5
		} else if course3Type == "G/T · AP" {
			course3Value += 1
		}
		
		if course4Grade == "A" {
			course4Value = 4
		} else if course4Grade == "B" {
			course4Value = 3
		} else if course4Grade == "C" {
			course4Value = 2
		} else if course4Grade == "D" {
			course4Value = 1
		} else {
			course4Value = 0
		}
		
		if course4Type == "Honors" {
			course4Value += 0.5
		} else if course4Type == "G/T · AP" {
			course4Value += 1
		}
		
		if course5Grade == "A" {
			course5Value = 4
		} else if course5Grade == "B" {
			course5Value = 3
		} else if course5Grade == "C" {
			course5Value = 2
		} else if course5Grade == "D" {
			course5Value = 1
		} else {
			course5Value = 0
		}
		
		if course5Type == "Honors" {
			course5Value += 0.5
		} else if course5Type == "G/T · AP" {
			course5Value += 1
		}
		
		if course6Grade == "A" {
			course6Value = 4
		} else if course6Grade == "B" {
			course6Value = 3
		} else if course6Grade == "C" {
			course6Value = 2
		} else if course6Grade == "D" {
			course6Value = 1
		} else {
			course6Value = 0
		}
		
		if course6Type == "Honors" {
			course6Value += 0.5
		} else if course6Type == "G/T · AP" {
			course6Value += 1
		}
		
		if course7Grade == "A" {
			course7Value = 4
		} else if course7Grade == "B" {
			course7Value = 3
		} else if course7Grade == "C" {
			course7Value = 2
		} else if course7Grade == "D" {
			course7Value = 1
		} else {
			course7Value = 0
		}
		
		if course7Type == "Honors" {
			course7Value += 0.5
		} else if course7Type == "G/T · AP" {
			course7Value += 1
		}
		
		let finalValue = (course1Value + course2Value + course3Value + course4Value + course5Value + course6Value + course7Value) / 7
		
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
									ForEach(grades, id: \.self) {
										Text($0)
									}
								}
								
								Picker("Type", selection: $course1Type) {
									ForEach(types, id: \.self) {
										Text($0)
									}
								}
							}
						}
						
						VStack(alignment: .leading) {
							Text("Course 2")
								.fontWeight(.semibold)
							
							HStack(spacing: 32) {
								Picker("Grade", selection: $course2Grade) {
									ForEach(grades, id: \.self) {
										Text($0)
									}
								}
								
								Picker("Type", selection: $course2Type) {
									ForEach(types, id: \.self) {
										Text($0)
									}
								}
							}
						}
						
						VStack(alignment: .leading) {
							Text("Course 3")
								.fontWeight(.semibold)
							
							HStack(spacing: 32) {
								Picker("Grade", selection: $course3Grade) {
									ForEach(grades, id: \.self) {
										Text($0)
									}
								}
								
								Picker("Type", selection: $course3Type) {
									ForEach(types, id: \.self) {
										Text($0)
									}
								}
							}
						}
						
						VStack(alignment: .leading) {
							Text("Course 4")
								.fontWeight(.semibold)
							
							HStack(spacing: 32) {
								Picker("Grade", selection: $course4Grade) {
									ForEach(grades, id: \.self) {
										Text($0)
									}
								}
								
								Picker("Type", selection: $course4Type) {
									ForEach(types, id: \.self) {
										Text($0)
									}
								}
							}
						}
						
						VStack(alignment: .leading) {
							Text("Course 5")
								.fontWeight(.semibold)
							
							HStack(spacing: 32) {
								Picker("Grade", selection: $course5Grade) {
									ForEach(grades, id: \.self) {
										Text($0)
									}
								}
								
								Picker("Type", selection: $course5Type) {
									ForEach(types, id: \.self) {
										Text($0)
									}
								}
							}
						}
						
						VStack(alignment: .leading) {
							Text("Course 6")
								.fontWeight(.semibold)
							
							HStack(spacing: 32) {
								Picker("Grade", selection: $course6Grade) {
									ForEach(grades, id: \.self) {
										Text($0)
									}
								}
								
								Picker("Type", selection: $course6Type) {
									ForEach(types, id: \.self) {
										Text($0)
									}
								}
							}
						}
						
						VStack(alignment: .leading) {
							Text("Course 7")
								.fontWeight(.semibold)
							
							HStack(spacing: 32) {
								Picker("Grade", selection: $course7Grade) {
									ForEach(grades, id: \.self) {
										Text($0)
									}
								}
								
								Picker("Type", selection: $course7Type) {
									ForEach(types, id: \.self) {
										Text($0)
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
									ForEach(grades, id: \.self) {
										Text($0)
									}
								}
								
								Picker("Type", selection: $course1Type) {
									ForEach(types, id: \.self) {
										Text($0)
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
									ForEach(grades, id: \.self) {
										Text($0)
									}
								}
								
								Picker("Type", selection: $course2Type) {
									ForEach(types, id: \.self) {
										Text($0)
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
									ForEach(grades, id: \.self) {
										Text($0)
									}
								}
								
								Picker("Type", selection: $course3Type) {
									ForEach(types, id: \.self) {
										Text($0)
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
									ForEach(grades, id: \.self) {
										Text($0)
									}
								}
								
								Picker("Type", selection: $course4Type) {
									ForEach(types, id: \.self) {
										Text($0)
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
									ForEach(grades, id: \.self) {
										Text($0)
									}
								}
								
								Picker("Type", selection: $course5Type) {
									ForEach(types, id: \.self) {
										Text($0)
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
									ForEach(grades, id: \.self) {
										Text($0)
									}
								}
								
								Picker("Type", selection: $course6Type) {
									ForEach(types, id: \.self) {
										Text($0)
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
									ForEach(grades, id: \.self) {
										Text($0)
									}
								}
								
								Picker("Type", selection: $course7Type) {
									ForEach(types, id: \.self) {
										Text($0)
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
						course1Grade = "A"
						course2Grade = "A"
						course3Grade = "A"
						course4Grade = "A"
						course5Grade = "A"
						course6Grade = "A"
						course7Grade = "A"
						
						course1Type = "Regular"
						course2Type = "Regular"
						course3Type = "Regular"
						course4Type = "Regular"
						course5Type = "Regular"
						course6Type = "Regular"
						course7Type = "Regular"
					}
				}
			}
		}
	}
}

#Preview {
	GPAView()
}
