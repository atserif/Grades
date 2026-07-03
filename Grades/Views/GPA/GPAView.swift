//
//  GPAView.swift
//  Grades
//
//  Created by Aram Soneson on 1/20/26.
//

import SwiftUI

struct GPAView: View {
	@Environment(\.horizontalSizeClass) private var horizontalSizeClass
	
	@State private var courses: [Course] = [
		Course(name: "", grade: .A, level: .regular),
		Course(name: "", grade: .A, level: .regular),
		Course(name: "", grade: .A, level: .regular),
		Course(name: "", grade: .A, level: .regular),
		Course(name: "", grade: .A, level: .regular),
		Course(name: "", grade: .A, level: .regular),
		Course(name: "", grade: .A, level: .regular)
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
		switch horizontalSizeClass {
		case .regular:
			"Grade Point Average"
		case .compact, .none, .some:
			"GPA"
		}
	}
	
	var body: some View {
		NavigationStack {
			if courses.isEmpty {
				ContentUnavailableView("No Courses", systemImage: "graduationcap.fill", description: Text("Your courses will appear here."))
					.navigationTitle(navigationTitle)
					.navigationSubtitle(navigationTitle)
					.toolbarTitleDisplayMode(.inlineLarge)
					#if os(iOS)
					.background(Color(.systemGroupedBackground))
					#endif
					.toolbar {
						ToolbarItemGroup(placement: .primaryAction) {
							Button("New Course", systemImage: "plus") {
								withAnimation {
									let newCourse = Course(name: "", grade: .A, level: .regular)
									courses.append(newCourse)
								}
							}
							.disabled(courses.count >= 100)
							
							Button("Reset", systemImage: "arrow.counterclockwise") {
								withAnimation {
									courses = [
										Course(name: "", grade: .A, level: .regular),
										Course(name: "", grade: .A, level: .regular),
										Course(name: "", grade: .A, level: .regular),
										Course(name: "", grade: .A, level: .regular),
										Course(name: "", grade: .A, level: .regular),
										Course(name: "", grade: .A, level: .regular),
										Course(name: "", grade: .A, level: .regular)
									]
								}
							}
						}
					}
			} else {
				Form {
					switch horizontalSizeClass {
					case .regular:
						RegularGPAContent(courses: $courses, unweightedGPA: unweightedGPA, weightedGPA: weightedGPA)
					case .compact, .none, .some:
						CompactGPAContent(courses: $courses, unweightedGPA: unweightedGPA, weightedGPA: weightedGPA)
					}
				}
				.formStyle(.grouped)
				.navigationTitle(navigationTitle)
				.toolbarTitleDisplayMode(.inlineLarge)
				.scrollDismissesKeyboard(.interactively)
				.toolbar {
					ToolbarItemGroup(placement: .primaryAction) {
						Button("New Course", systemImage: "plus") {
							withAnimation {
								let newCourse = Course(name: "", grade: .A, level: .regular)
								courses.append(newCourse)
							}
						}
						.disabled(courses.count >= 100)
						
						Button("Reset", systemImage: "arrow.counterclockwise") {
							withAnimation {
								courses = [
									Course(name: "", grade: .A, level: .regular),
									Course(name: "", grade: .A, level: .regular),
									Course(name: "", grade: .A, level: .regular),
									Course(name: "", grade: .A, level: .regular),
									Course(name: "", grade: .A, level: .regular),
									Course(name: "", grade: .A, level: .regular),
									Course(name: "", grade: .A, level: .regular)
								]
							}
						}
					}
				}
			}
		}
	}
}

#Preview {
	ContentView()
}
