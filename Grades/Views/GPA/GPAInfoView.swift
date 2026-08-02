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
				
				Section {
					Text("All GPA calculation information is derived from [Howard County Public School System Policy 8020](https://policy.hcpss.org/8000/8020/).")
						.font(.subheadline)
						.foregroundStyle(.secondary)
				}
				.listRowBackground(Color.clear)
				.listRowInsets(EdgeInsets(top: 0, leading: 16, bottom: 0, trailing: 16))
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
