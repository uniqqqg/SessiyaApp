//
//  HatView..swift
//  SessiyaApp
//
//  Created by Глеб Моргунов on 24.01.26.
//

import SwiftUI

struct HatView: View {
	
	@State var sheetSettingsOn: Bool = false
	
    var body: some View {
		hatView
		
			.sheet(isPresented: $sheetSettingsOn) {
				SettingsTimerView(minutes: .constant(10))
			}
    }
	
	private var hatView: some View {
		VStack(spacing: 10) {
			VStack(spacing: .zero) {
					HStack(spacing: 20) {
						
						Button {
							
						} label: {
							Image(systemName: "chart.bar.fill")
								.resizable()
								.scaledToFit()
								.frame(width: 30, height: 30)
								.foregroundStyle(.white)
						}
						
						Text("Pomodoro Timer")
							.foregroundStyle(.white)
							.fontWeight(.bold)
							.padding(.horizontal, 40)
						
						Button {
							sheetSettingsOn.toggle()
						} label: {
							Image(systemName: "gear")
								.resizable()
								.scaledToFit()
								.frame(width: 30, height: 30)
								.foregroundStyle(.white)
						}
					}
					.frame( maxWidth: .infinity, alignment: .center)
					.padding(.horizontal, 5)
					
					Image("tomato")
						.resizable()
						.scaledToFit()
						.frame(width: 150, height: 150)
						
					
					Divider()
						.frame(height: 1)
						.background(.white)
						.padding(.horizontal, 30)
					
				}
				.padding()
		}
	}
}

#Preview {
	NavigationStack {
		HatView()
	}
}
