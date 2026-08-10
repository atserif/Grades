//
//  PresentationRimLight.swift
//  Grades
//
//  Created by Aram Soneson on 7/29/26.
//

import SwiftUI

// TODO: Add documentation
struct PresentationRimLight: ViewModifier {
	@Environment(\.colorScheme) private var colorScheme
	
	private var visibility: Visibility = .automatic
	
	// TODO: Make presentationRimLight appear on sheets by default
	func body(content: Content) -> some View {
		if visibility == .visible {
			content
				.overlay {
					ContainerRelativeShape()
						.strokeBorder(.white.opacity(0.075).exposureAdjust(colorScheme == .dark ? 0 : 1.5), lineWidth: 1)
						.ignoresSafeArea()
						.mask {
							VStack(spacing: 0) {
								LinearGradient(gradient: Gradient(colors: [.black, .clear]), startPoint: .top, endPoint: .bottom)
									.frame(height: 70)
								
								Rectangle()
									.fill(.clear)
							}
						}
				}
		}
	}
}

extension View {
	func presentationRimLight(_ visibility: Visibility) -> some View {
		modifier(PresentationRimLight())
	}
}
