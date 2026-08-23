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
		if let version = Bundle.main.infoDictionary?["CFBundleShortVersionString"] as? String, let build = Bundle.main.infoDictionary?["CFBundleVersion"] as? String {
			UserDefaults.standard.set("\(version) (\(build))", forKey: "version")
		}
	}
	
	var body: some Scene {
		WindowGroup {
			ContentView()
		}
	}
}
