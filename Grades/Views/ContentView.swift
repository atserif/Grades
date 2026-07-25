//
//  ContentView.swift
//  Grades
//
//  Created by Aram Soneson on 1/20/26.
//

import SwiftUI

private enum TabSelection {
	case grades
	case gpa
}

struct ContentView: View {
	@Environment(\.horizontalSizeClass) private var horizontalSizeClass
	
	@State private var tabSelection: TabSelection = .grades
	
	var body: some View {
		TabView(selection: $tabSelection) {
			Tab("Grades", systemImage: "checklist", value: .grades) {
				GradesView()
			}
			
			Tab("GPA", systemImage: "sum", value: .gpa) {
				GPAView()
			}
		}
	}
}

#Preview {
	ContentView()
}
