//
//  PresentationRimLight.swift
//  Grades
//
//  Created by Aram Soneson on 7/29/26.
//

import SwiftUI

struct PresentationRimLight: ViewModifier {
	@Environment(\.colorScheme) private var colorScheme
	
	func body(content: Content) -> some View {
		content
			.overlay {
				ContainerRelativeShape()
					.strokeBorder(.white.opacity(0.075).exposureAdjust(colorScheme == .dark ? 0 : 2), lineWidth: 1)
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

extension View {
	func presentationRimLight() -> some View {
		modifier(PresentationRimLight())
	}
}
