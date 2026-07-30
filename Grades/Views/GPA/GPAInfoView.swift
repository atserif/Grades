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
					Text("Course Scoring")
						.font(.headline)
					
					Text("Regular courses are worth 4.0 points, Honors courses are worth 4.5 points, and G/T & AP courses are worth 5.0 points.")
						.font(.subheadline)
						.foregroundStyle(.secondary)
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
		}
}
