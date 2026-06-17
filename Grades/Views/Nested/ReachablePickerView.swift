//
//  ReachablePickerView.swift
//  Grades
//
//  Created by Aram Soneson on 6/15/26.
//

import SwiftUI

struct ReachablePickerView: View {
	var body: some View {
		ScrollView(.horizontal) {
			LazyHStack(spacing: 32) {
				ForEach(TabSelection.allCases) { tab in
					HStack {
						Image(systemName: tab.symbol)
						
						Text(tab.rawValue)
					}
					.frame(maxWidth: .infinity, maxHeight: .infinity)
					.buttonStyle(.plain)
					.containerRelativeFrame([.horizontal])
					.glassEffect(.regular.tint(.white.opacity(0.4)))
					.clipShape(.capsule)
				}
			}
			.scrollTargetLayout()
		}
		.frame(height: 40)
		.clipShape(.capsule)
		.padding(4)
		.glassEffect(.regular.interactive())
		.scrollTargetBehavior(.viewAligned)
		.scrollIndicators(.hidden)
	}
}

#Preview {
	ContentView()
}
