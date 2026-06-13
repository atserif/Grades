//
//  SettingsView.swift
//  Grades
//
//  Created by Aram Soneson on 6/13/26.
//

import SwiftUI

struct SettingsView: View {
	@State private var tabSelection: SettingsTabSelection = .general
	
    var body: some View {
		TabView(selection: $tabSelection.animation()) {
			Tab("General", systemImage: "gearshape", value: .general) {
				GeneralSettingsView()
			}
			
			Tab("Advanced", systemImage: "gearshape.2", value: .advanced) {
				AdvancedSettingsView()
			}
		}
    }
}

#Preview {
    SettingsView()
}
