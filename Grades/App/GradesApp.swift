//
//  GradesApp.swift
//  Grades
//
//  Created by Aram Soneson on 1/20/26.
//

import SwiftUI

@main
struct GradesApp: App {
	init() {
		// Set version and build numbers
		if let version = Bundle.main.infoDictionary?["CFBundleShortVersionString"] as? String, let build = Bundle.main.infoDictionary?["CFBundleVersion"] as? String {
			UserDefaults.standard.set("\(version) (\(build))", forKey: "version")
		}
		
		// Apply keyboard dismiss behavior that doesn't have scrollDismissesKeyboard's janky animation
		UIScrollView.appearance().keyboardDismissMode = .onDrag
	}
	
	var body: some Scene {
		WindowGroup {
			ContentView()
		}
	}
}
