//
//  CopyToClipboard.swift
//  Grades
//
//  Created by Aram Soneson on 4/10/26.
//

import SwiftUI

extension View {
	func copyToClipboard(_ text: String) {
		UIPasteboard.general.string = text
	}
}
