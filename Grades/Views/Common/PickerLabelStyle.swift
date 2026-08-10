//
//  SimpleLabelStyle.swift
//  Grades
//
//  Created by Aram Soneson on 7/24/26.
//

import SwiftUI

struct PickerLabelStyle: LabelStyle {
	@Environment(\.accessibilityShowBorders) private var accessibilityShowBorders
	
	func makeBody(configuration: Configuration) -> some View {
		if accessibilityShowBorders {
			HStack(spacing: 4) {
				configuration.icon
				
				configuration.title
					.underline(false)
				
				Image(systemName: "chevron.up.chevron.down")
					.imageScale(.small)
			}
			.tint(.secondary)
			// Matches default Picker styling when Show Borders is enabled
			.padding(.vertical, 8)
			.padding(.horizontal, 12)
			.background(Color(.tertiarySystemFill))
			.clipShape(.capsule)
		} else {
			HStack(spacing: 4) {
				configuration.icon
				
				configuration.title
				
				Image(systemName: "chevron.up.chevron.down")
					.imageScale(.small)
			}
			.tint(.secondary)
		}
	}
}
