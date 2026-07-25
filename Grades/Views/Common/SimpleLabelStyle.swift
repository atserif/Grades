//
//  SimpleLabelStyle.swift
//  Grades
//
//  Created by Aram Soneson on 7/24/26.
//

import SwiftUI

struct SimpleLabelStyle: LabelStyle {
	func makeBody(configuration: Configuration) -> some View {
		HStack(spacing: 4) {
			configuration.icon
			
			configuration.title
			
			Image(systemName: "chevron.up.chevron.down")
				.imageScale(.small)
		}
		.font(.callout)
		.tint(.secondary)
	}
}

extension LabelStyle where Self == SimpleLabelStyle {
	static var simple: SimpleLabelStyle { SimpleLabelStyle() }
}
