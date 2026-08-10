//
//  StaticNavigationTitle.swift
//  Grades
//
//  Created by Aram Soneson on 7/10/26.
//

import SwiftUI

// Custom inlineLarge navigation title that doesn't collapse on scroll
struct StaticNavigationTitle: View {
	@Environment(\.horizontalSizeClass) private var horizontalSizeClass
	
	var title: String
	
	var body: some View {
		if horizontalSizeClass == .compact {
			HStack {
				Text(title)
					.font(.largeTitle)
					.bold()
					.fixedSize()
				
				Spacer()
			}
		}
	}
}
