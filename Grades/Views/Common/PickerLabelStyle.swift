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
				
				Image(systemName: "chevron.up.chevron.down")
					.imageScale(.small)
			}
			.padding(.vertical, 8)
			.padding(.horizontal, 12)
			.background(Color(.tertiarySystemFill))
			.foregroundStyle(.secondary)
			.clipShape(.capsule)
		} else {
			HStack(spacing: 4) {
				configuration.icon
				
				configuration.title
				
				Image(systemName: "chevron.up.chevron.down")
					.imageScale(.small)
			}
			.foregroundStyle(.secondary)
		}
	}
}

extension LabelStyle where Self == PickerLabelStyle {
	static var picker: PickerLabelStyle {
		PickerLabelStyle()
	}
}
