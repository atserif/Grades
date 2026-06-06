//
//  CopyableRow.swift
//  Grades
//
//  Created by Aram Soneson on 6/5/26.
//

import SwiftUI

struct CopyableRow: View {
	let label: String
	let value: String
	@State private var hovered: Bool = false
	@State private var clicked: Bool = false
	
	var body: some View {
		#if os(macOS)
		HStack {
			Text(label)
			
			Spacer()
			
			Button {
				if !clicked {
					withAnimation(.easeInOut(duration: 0.3)) {
						Copy.copyToClipboard(value)
						clicked = true
					}
					
					DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
						withAnimation(.easeInOut(duration: 0.3)) {
							clicked = false
						}
					}
				}
			} label: {
				// TODO: Fix hover effect flickering while animation is playing
				Label {
					Text(clicked ? "Copied" : value)
				} icon: {
					if clicked {
						Image(systemName: "document.on.document.fill")
							.transition(.move(edge: .trailing).combined(with: .opacity).combined(with: .blurReplace))
					}
				}
				.padding(clicked ? 7 : 5)
				.labelIconToTitleSpacing(4)
				.foregroundStyle(.secondary)
				.background(clicked ? Color(.tertiarySystemFill) : hovered ? Color(.tertiarySystemFill) : .clear)
				.clipShape(.rect(cornerRadius: clicked ? 9 : 7))
				.contentTransition(.numericText())
				.animation(.default, value: value)
				.monospacedDigit()
				.onHover { isHovering in
					hovered = isHovering
				}
			}
			.buttonStyle(UnresponsiveButtonStyle())
			.offset(x: clicked ? 0 : -2)
			.padding(-7)
		}
		#else
		LabeledContent("Course Grade", value: value)
			.contextMenu {
				Button("Copy Course Grade", systemImage: "document.on.document") {
					Copy.copyToClipboard(value)
				}
			}
		#endif
	}
}

