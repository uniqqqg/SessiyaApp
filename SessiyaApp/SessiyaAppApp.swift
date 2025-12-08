//
//  SessiyaAppApp.swift
//  SessiyaApp
//
//  Created by Глеб Моргунов on 22.11.25.
//

import SwiftUI

@main
struct SessiyaAppApp: App {
	
	@AppStorage("hasCompletedOnboarding") var hasCompletedOnboarding = false

    var body: some Scene {
        WindowGroup {
			if hasCompletedOnboarding {
				HomeView()
			} else {
				HomeView()
				}
        }
    }
}
