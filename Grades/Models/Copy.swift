//
//  Copy.swift
//  Grades
//
//  Created by Aram Soneson on 4/10/26.
//

import SwiftUI

struct Copy {
	static func copyToClipboard(_ text: String) {
		#if os(macOS)
		NSPasteboard.general.clearContents()
		NSPasteboard.general.setString(text, forType: .string)
		#else
		UIPasteboard.general.string = text
		#endif
	}
}
