//
//  SettingsTimerView.swift
//  SessiyaApp
//
//  Created by Глеб Моргунов on 22.01.26.
//

import SwiftUI

struct SettingsTimerView: View {
	@Binding var minutes: Double
	var range: ClosedRange<Double> = 1...60
	
    var body: some View {
		settingsTimer
    }
	
	private var settingsTimer: some View {
		VStack(spacing: 10) {
			Text("Настройки таймера")
				.frame(maxWidth: .infinity, alignment: .leading)
				.padding()
			
			Slider(value: $minutes, in: range, step: 1)
				.accentColor(.black)
				.padding()
		}
	}
}

#Preview {
	SettingsTimerView(minutes: .constant(1))
}
