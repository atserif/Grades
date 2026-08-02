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
					
					Grid(alignment: .leading) {
						GridRow {
							HStack { }
							Text("Regular")
							Text("Honors")
							Text("G/T · AP")
						}
						
						GridRow {
							Text("A")
							Text("5.0")
							Text("4.5")
							Text("4.0")
						}
						
						GridRow {
							Text("B")
							Text("4.0")
							Text("3.5")
							Text("3.0")
						}
						
						GridRow {
							Text("C")
							Text("3.0")
							Text("2.5")
							Text("2.0")
						}
						
						GridRow {
							Text("D")
							Text("1.0")
							Text("1.0")
							Text("1.0")
						}
						
						GridRow {
							Text("E")
							Text("0")
							Text("0")
							Text("0")
						}
					}
					.monospacedDigit()
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
