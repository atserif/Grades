//
//  CopyableRow.swift
//  Grades
//
//  Created by Aram Soneson on 6/5/26.
//

import SwiftUI

struct CopyableRow: View {
	@State private var isHovered: Bool = false
	@State private var isClicked: Bool = false
	
	let label: String
	let value: String
	
	var body: some View {
		#if os(macOS)
		HStack {
			Text(label)
			
			Spacer()
			
			Button {
				if !isClicked {
					withAnimation(.easeInOut(duration: 0.3)) {
						Copy.copyToClipboard(value)
						isClicked = true
					}
					
					DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
						withAnimation(.easeInOut(duration: 0.3)) {
							isClicked = false
						}
					}
				}
			} label: {
				// TODO: Fix hover effect flickering while animation is playing
				Label {
					Text(isClicked ? "Copied" : value)
				} icon: {
					if isClicked {
						Image(systemName: "document.on.document.fill")
							.transition(.move(edge: .trailing).combined(with: .opacity).combined(with: .blurReplace))
					}
				}
				.padding(isClicked ? 7 : 5)
				.labelIconToTitleSpacing(4)
				.foregroundStyle(.secondary)
				.background(isClicked ? Color(.tertiarySystemFill) : isHovered ? Color(.tertiarySystemFill) : .clear)
				.clipShape(.rect(cornerRadius: isClicked ? 9 : 7))
				.contentTransition(.numericText())
				.animation(.default, value: value)
				.monospacedDigit()
				.onHover {
					isHovered = $0
				}
			}
			.buttonStyle(UnresponsiveButtonStyle())
			.offset(x: isClicked ? 0 : -2)
			.padding(-7)
		}
		#else
		LabeledContent(label) {
			Text(value)
				.monospacedDigit()
		}
		.contentTransition(.numericText())
		.animation(.default, value: value)
		.contextMenu {
			Button("Copy \(label)", systemImage: "document.on.document") {
				Copy.copyToClipboard(value)
			}
		}
		#endif
	}
}

