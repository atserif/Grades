//
//  GradesApp.swift
//  Grades
//
//  Created by Aram Soneson on 1/20/26.
//

import SwiftUI

@main
struct GradesApp: App {
	var body: some Scene {
		#if os(macOS)
		Window("Grades", id: "grades") {
			ContentView()
				.frame(minWidth: 800, idealWidth: 800, minHeight: 500, idealHeight: 500)
				.onAppear {
					NSWindow.allowsAutomaticWindowTabbing = false
				}
		}
		.commands {
			CommandGroup(replacing: .systemServices) { }
		}
		
//		Settings {
//			SettingsView()
//				.frame(maxWidth: 400)
//				.fixedSize(horizontal: false, vertical: true)
//				.windowResizeAnchor(.top)
//		}
		#else
		WindowGroup {
			ContentView()
		}
		#endif
	}
}
