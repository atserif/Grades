//
//  Untitled.swift
//  Grades
//
//  Created by Aram Soneson on 6/16/26.
//

import SwiftUI

struct LiquidGlassMorphView: View {
	@Namespace private var glassNamespace
	@State private var isExpanded = false
	
	var body: some View {
		ZStack {
			// High-contrast background helps showcase the real-time glass refraction
			LinearGradient(colors: [.purple, .indigo, .cyan], startPoint: .topLeading, endPoint: .bottomTrailing)
				.ignoresSafeArea()
			
			// 1. Wrap views inside the container to handle liquid fusion properties
			GlassEffectContainer(spacing: 35) {
				if !isExpanded {
					// Small floating action circle
					Button(action: { withAnimation(.spring(response: 0.5, dampingFraction: 0.7)) { isExpanded.toggle() } }) {
						Image(systemName: "plus")
							.font(.title2.bold())
							.frame(width: 60, height: 60)
					}
					.glassEffect() // Applies the liquid glass material base
					.glassEffectID("liquidControl", in: glassNamespace) // Binds geometry for morphing
				} else {
					// Smoothly expanded menu layout
					VStack(spacing: 15) {
						Button("Action One") { }
						Button("Action Two") { }
						Button("Close") {
							withAnimation(.spring(response: 0.5, dampingFraction: 0.7)) { isExpanded.toggle() }
						}
						.fontWeight(.bold)
					}
					.padding()
					.frame(width: 200, height: 180)
					.glassEffect()
					.glassEffectID("liquidControl", in: glassNamespace) // Matches original element ID
				}
			}
		}
	}
}

#Preview {
	LiquidGlassMorphView()
}
