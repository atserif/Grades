//
//  CapsuleLabelStyle.swift
//  Grades
//
//  Created by Aram Soneson on 7/24/26.
//

import SwiftUI

private struct CapsuleLabelStyle: LabelStyle {
	func makeBody(configuration: Configuration) -> some View {
		Label {
			configuration.title
				.padding(.trailing, 4)
		} icon: {
			configuration.icon
				.imageScale(.medium)
		}
		.foregroundStyle(.accent)
		.font(.callout)
		.fontWeight(.medium)
		.labelIconToTitleSpacing(2)
		.padding(8)
		.background(Color(.tertiarySystemGroupedBackground))
		.clipShape(.capsule)
	}
}

struct CapsuleMenuStyle: MenuStyle {
	func makeBody(configuration: Configuration) -> some View {
		Menu(configuration)
			.labelStyle(CapsuleLabelStyle())
	}
}

extension MenuStyle where Self == CapsuleMenuStyle {
	static var capsule: CapsuleMenuStyle { CapsuleMenuStyle() }
}
