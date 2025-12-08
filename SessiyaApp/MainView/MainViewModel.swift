//
//  MainViewModel.swift
//  SessiyaApp
//
//  Created by Глеб Моргунов on 27.11.25.
//

import Foundation
import Combine
import SwiftUI

class MainViewModel: ObservableObject {
	@Published var isPresented: Bool = false
	@Published var selectedTab: Int = 0
	 let tabItems: [TabItemData] = [
		TabItemData(imageName: "house", destination: AnyView(HomeView())),
		TabItemData(imageName: "gauge.with.needle", destination: AnyView(TimerView())),
		TabItemData(imageName: "plus.app.fill", destination: AnyView(AddDataView())),
		TabItemData(imageName: "gear", destination: AnyView(SettingsView())),
		TabItemData(imageName: "person.crop.circle.fill", destination: AnyView(ProfileView()))
	]
	
}
