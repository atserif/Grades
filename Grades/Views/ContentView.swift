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
	
	@State private var reachablePickerPresented: Bool = false
	
	@Namespace private var transition
	
	private var stateAssessedTabDisplayName: String {
		if horizontalSizeClass == .compact {
			"State"
		} else {
			"State-Assessed"
		}
	}
	
	var body: some View {
		switch layout {
		case .default:
			TabView(selection: $tabSelection) {
				Tab("Full Year", systemImage: "calendar", value: .fullYear) {
					FullYearView()
				}
				
				Tab("Semester", systemImage: "circle.lefthalf.striped.horizontal", value: .semester) {
					SemesterView()
				}
				
				Tab(stateAssessedTabDisplayName, systemImage: "mappin.and.ellipse", value: .stateAssessed) {
					StateAssessedView()
				}
				
				Tab("GPA", systemImage: "rosette", value: .gpa) {
					GPAView()
				}
			}
		case .reachable:
			NavigationStack {
				ZStack {
					switch tabSelection {
					case .fullYear:
						FullYearView()
					case .semester:
						SemesterView()
					case .stateAssessed:
						StateAssessedView()
					case .gpa:
						GPAView()
					}
				}
				.toolbar {
					ToolbarItem(placement: .bottomBar) {
						Button("Settings", systemImage: "switch.2") {
							
						}
					}
					
					ToolbarSpacer(.flexible, placement: .bottomBar)
					
					ToolbarItem(placement: .bottomBar) {
						Button {
							reachablePickerPresented = true
						} label: {
							HStack {
								Image(systemName: tabSelection.description)
								
								Text(tabSelection.rawValue)
								
								Image(systemName: "chevron.up.chevron.down")
									.foregroundStyle(.tertiary)
									.font(.system(size: 10, weight: .semibold))
							}
							.padding(.horizontal, 8)
						}
					}
					.matchedTransitionSource(id: "reachablePicker", in: transition)
					
					ToolbarSpacer(.flexible, placement: .bottomBar)
					
					ToolbarItem(placement: .bottomBar) {
						Button("Reset", systemImage: "arrow.clockwise") {
							
						}
					}
					
				}
				.sheet(isPresented: $reachablePickerPresented) {
					ReachablePickerView(tabSelection: $tabSelection)
						.presentationDetents([.fraction(0.4)])
						.navigationTransition(.zoom(sourceID: "reachablePicker", in: transition))
						
				}
			}
		}
	}
}

#Preview {
	ContentView()
}
