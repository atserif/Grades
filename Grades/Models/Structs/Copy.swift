//
//  Copy.swift
//  Grades
//
//  Created by Aram Soneson on 4/10/26.
//

import SwiftUI

struct Copy {
	static func copyToClipboard(_ text: String) {
		UIPasteboard.general.string = text
	}
}
