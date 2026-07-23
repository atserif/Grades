//
//  StaticNavigationTitle.swift
//  Grades
//
//  Created by Aram Soneson on 7/10/26.
//

import SwiftUI

struct StaticNavigationTitle: View {
	var title: String
	
	var body: some View {
		HStack {
			Text(title)
				.font(.largeTitle)
				.bold()
				.fixedSize()
			
			Spacer()
		}
	}
}

#Preview {
	NavigationStack {
		ScrollView {
			Text("Hello, world!")
		}
		.toolbar {
			ToolbarItem(placement: .title) {
				StaticNavigationTitle(title: "Title")
			}
		}
		.toolbarTitleDisplayMode(.inline)
		.toolbarRole(.editor)
	}
}
