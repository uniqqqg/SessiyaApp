//
//  ContentView.swift
//  SessiyaApp
//
//  Created by Глеб Моргунов on 22.11.25.
//

import SwiftUI

struct ContentView: View {
	
	@AppStorage("hasCompletedOnboarding") var hasCompletedOnboarding = false
	
	var body: some View {
		if hasCompletedOnboarding {
			BenefitsForUserView()
		} else {
			QuestionsView()
		}
	}
}

#Preview {
    ContentView()
}
