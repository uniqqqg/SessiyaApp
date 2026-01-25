//
//  TimerView.swift
//  SessiyaApp
//
//  Created by Глеб Моргунов on 27.11.25.
//

import SwiftUI

struct TimerView: View {
	
	var body: some View {
		VStack(spacing: 10) {
			ZStack {
				Color.system
					.ignoresSafeArea()
				VStack(spacing: 15) {
					RoundedRectangle(cornerRadius: 30)
						.fill(.system)
						.shadow(radius: 20)
						.padding(.vertical, 10)
						.padding(.horizontal, 20)
						.padding(.bottom, 50)
						.overlay {
							VStack(spacing: 10) {
								HatView()
									.padding(.top, 30)
								ModePickerView()
									.padding()
								TimerDisplayView()
									.padding(20)
								ControlButton()
								Spacer()
							}
						}
				}
				
			}
			
		}
	}


	}


#Preview {
	TimerView()
}
