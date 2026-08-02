//
//  GPAInfoView.swift
//  Grades
//
//  Created by Aram Soneson on 7/30/26.
//

import SwiftUI

struct GPAInfoView: View {
	@Environment(\.dismiss) private var dismiss
	
	var body: some View {
		NavigationStack {
			List {
				Section {
					Text("Grade Values")
						.font(.headline)
					
					ForEach(Grade.allCases, id: \.self) { grade in
						LabeledContent(grade.description, value: String(grade.rawValue))
							.monospacedDigit()
					}
				}
				
				Section {
					Text("Level Values")
						.font(.headline)
					
					ForEach(Level.allCases, id: \.self) { level in
						LabeledContent(level.description, value: String(level.rawValue))
							.monospacedDigit()
					}
				}
			}
			.listSectionSpacing(.compact)
			.toolbar {
				ToolbarItem(placement: .cancellationAction) {
					Button("Close", systemImage: "xmark", role: .close) {
						dismiss()
					}
				}
			}
			.navigationTitle("About GPA")
			.toolbarTitleDisplayMode(.inline)
			.scrollEdgeEffectStyle(.soft, for: .all)
			.contentMargins(.top, 10)
		}
	}
}

#Preview {
	VStack { }
		.sheet(isPresented: .constant(true)) {
			GPAInfoView()
				.presentationRimLight()
				.interactiveDismissDisabled()
		}
}
