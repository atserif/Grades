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
					withAnimation(.spring(duration: 0.4)) {
						Copy.copyToClipboard(value)
						clicked = true
					}
					
					DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
						withAnimation(.spring(duration: 0.4)) {
							clicked = false
						}
					}
				}
			} label: {
				if clicked {
					HStack(spacing: 4) {
						Image(systemName: "document.on.document.fill")
							.padding(.vertical, -4)
						
						Text("Copied")
					}
					.padding(7)
					.background(hovered ? Color(.tertiarySystemFill) : .clear)
					.foregroundStyle(.secondary)
					.clipShape(.rect(cornerRadius: 9))
					.transition(.scale(scale: 0.8).combined(with: .opacity))
					.onHover {
						hovered = $0
					}
				} else {
					Text(value)
						.padding(5)
						.background(hovered ? Color(.tertiarySystemFill) : .clear)
						.foregroundStyle(.secondary)
						.clipShape(.rect(cornerRadius: 7))
						.transition(.scale(scale: 0.8).combined(with: .opacity))
						.onHover {
							hovered = $0
						}
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

