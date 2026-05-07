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
		WindowGroup {
			ContentView()
				.frame(minWidth: 800, idealWidth: 900, minHeight: 500, idealHeight: 550)
				.onAppear {
					NSWindow.allowsAutomaticWindowTabbing = false
				}
		}
		.commands {
			CommandGroup(replacing: .undoRedo) { }
			CommandGroup(replacing: .pasteboard) { }
			CommandGroup(replacing: .systemServices) { }
		}
		#else
		WindowGroup {
			ContentView()
		}
		#endif
	}
}
