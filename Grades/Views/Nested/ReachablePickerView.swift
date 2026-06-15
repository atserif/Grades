//
//  ReachablePickerView.swift
//  Grades
//
//  Created by Aram Soneson on 6/15/26.
//

import SwiftUI

struct ReachablePickerView: View {
	@Environment(\.dismiss) private var dismiss
	
	@Binding var tabSelection: TabSelection
	
	var body: some View {
		NavigationStack {
			List {
				ForEach(TabSelection.allCases, id: \.self) { tab in
//					Section {
						Button(tab.rawValue, systemImage: tab.description) {
							tabSelection = tab
							
							dismiss()
						}
//					}
//					.listRowBackground(Color(.clear))
				}
			}
			.foregroundStyle(.primary)
//			.listSectionSpacing(0)
			.contentMargins(.vertical, 0)
			.scrollDisabled(true)
			.toolbar {
				ToolbarItem(placement: .topBarLeading) {
					Button("Close", systemImage: "xmark", role: .close) {
						dismiss()
					}
				}
			}
		}
	}
}

#Preview {
	@State @Previewable var previewReachablePickerPresented: Bool = true
	@State @Previewable var previewTabSelection: TabSelection = .fullYear

	NavigationStack {
		ZStack { }
			.toolbar {
				ToolbarItem(placement: .status) {
					Button("Open Sheet") {
						previewReachablePickerPresented = true
					}
				}
			}
			.sheet(isPresented: $previewReachablePickerPresented) {
				ReachablePickerView(tabSelection: $previewTabSelection)
					.presentationDetents([.fraction(0.4)])
			}
	}
}
