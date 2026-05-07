//
//  UnresponsiveButtonStyle.swift
//  Grades
//
//  Created by Aram Soneson on 2/21/26.
//

import SwiftUI

struct UnresponsiveButtonStyle: ButtonStyle {
	func makeBody(configuration: Self.Configuration) -> some View {
		configuration.label
	}
}
