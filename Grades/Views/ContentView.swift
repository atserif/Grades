//
//  ContentView.swift
//  Grades
//
//  Created by Aram Soneson on 1/20/26.
//

import SwiftUI

struct ContentView: View {
	@Environment(\.horizontalSizeClass) private var horizontalSizeClass
	
	@State private var tabSelection: TabSelection = .courses
	
	var body: some View {
		TabView(selection: $tabSelection) {
			Tab("Courses", systemImage: "graduationcap", value: .courses) {
				CoursesView()
			}
			
			Tab("GPA", systemImage: "rosette", value: .gpa) {
				GPAView()
			}
		}
		.scrollEdgeEffectStyle(.soft, for: .all)
	}
}

#Preview {
	ContentView()
}
