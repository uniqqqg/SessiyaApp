//
//  MainView.swift
//  SessiyaApp
//
//  Created by Глеб Моргунов on 27.11.25.
//

import SwiftUI

struct MainView: View {
	
	@StateObject var viewModel = MainViewModel()
	
	var body: some View {
		TabView(selection: $viewModel.selectedTab) {
			ForEach(viewModel.tabItems.indices, id:\.self) { index in
				viewModel.tabItems[index].destination
					.tabItem {
						Label("", systemImage: viewModel.tabItems[index].imageName)
					}
					.tag(index)
			}
		}
		.tabViewStyle(.automatic)
		.tint(.blue)
	}
}

#Preview {
	MainView()
}
