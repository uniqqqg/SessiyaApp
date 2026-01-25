//
//  TimerDisplayView.swift
//  SessiyaApp
//
//  Created by Глеб Моргунов on 24.01.26.
//

import SwiftUI

struct TimerDisplayView: View {
    var body: some View {
		VStack(spacing: 10) {
			timerDisplay
		}
    }
	
	private var timerDisplay: some View {
		VStack(spacing: 10) {
			ZStack {
				Circle()
					.stroke(Color.tomato, lineWidth: 25)
					.frame(width: 200, height: 200)
					.aspectRatio(4, contentMode: .fill)
				
				Text("timer")
			}
		}
	}
}

#Preview {
    TimerDisplayView()
}
