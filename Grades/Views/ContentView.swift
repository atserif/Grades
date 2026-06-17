//
//  ContentView.swift
//  Grades
//
//  Created by Aram Soneson on 1/20/26.
//

import SwiftUI

struct ContentView: View {
	@Environment(\.horizontalSizeClass) private var horizontalSizeClass
	
	@State private var tabSelection: TabSelection = .fullYear
	@State private var layout: Layout = .reachable
	
	var body: some View {
		switch layout {
		case .default:
			TabView(selection: $tabSelection) {
				ForEach(TabSelection.allCases) { tab in
					Tab(tab.rawValue, systemImage: tab.symbol, value: tab) {
						AnyView(tab.view)
					}
				}
			}
		case .reachable:
			ScrollView(.horizontal) {
				LazyHStack(spacing: 40) {
					ForEach(TabSelection.allCases, id: \.self) { tab in
						AnyView(tab.view)
							.clipShape(ConcentricRectangle(corners: .concentric, isUniform: true))
							.ignoresSafeArea()
							.containerRelativeFrame([.horizontal, .vertical])
					}
				}
				.scrollTargetLayout()
			}
			.scrollTargetBehavior(.viewAligned)
			.scrollDisabled(true)
			.scrollIndicators(.hidden)
			.safeAreaBar(edge: .bottom, alignment: .center) {
				GlassEffectContainer {
					HStack {
						Menu("More", systemImage: "ellipsis") {
							Picker("Layout", selection: $layout) {
								ForEach(Layout.allCases, id: \.self) { layout in
									Text(layout.rawValue)
								}
							}
						}
						.buttonStyle(.plain)
						.buttonBorderShape(.circle)
						.frame(width: 48, height: 48)
						.labelStyle(.iconOnly)
						.font(.system(size: 22))
						.glassEffect(.regular.interactive())
						
						Spacer()
						
						ReachablePickerView()

						Spacer()
						
						Button("Reset", systemImage: "arrow.clockwise", role: .close) {
							
						}
						.buttonStyle(.plain)
						.buttonBorderShape(.circle)
						.frame(width: 48, height: 48)
						.labelStyle(.iconOnly)
						.font(.system(size: 22))
						.glassEffect(.regular.interactive())
					}
				}
				.safeAreaPadding(.horizontal, 28)
				.padding(.bottom, -6)
			}
		}
	}
}

#Preview {
	ContentView()
}

