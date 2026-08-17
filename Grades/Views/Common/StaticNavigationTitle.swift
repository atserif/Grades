//
//  StaticNavigationTitle.swift
//  Grades
//
//  Created by Aram Soneson on 7/10/26.
//

import SwiftUI

// Custom inlineLarge navigation title that doesn't collapse on scroll
struct StaticNavigationTitle: View {
	var title: String
	
	var body: some View {
		if UIDevice.current.userInterfaceIdiom == .phone {
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
