//
//  StartingScreen.swift
//  SessiyaApp
//
//  Created by Глеб Моргунов on 22.11.25.
//

import SwiftUI

struct StartingScreen: View {
	@State private var isAppeared: Bool = false
	@State private var nextScreen: Bool = false
	
	var body: some View {
	
		NavigationStack {
			VStack( spacing: 10 ) {
				firstView
				Spacer()
				buttontContainer
				
					.navigationDestination(isPresented: $nextScreen) {
						QuestionsView()
					}
			}
			.padding(32)
			
		}
	}
	
	private var firstView: some View {
		VStack(spacing: 50) {
			Image("puple1")
				.resizable()
				.scaledToFit()
				.frame(width: 240)
				.offset(x: isAppeared ? 0 : -UIScreen.main.bounds.width)
				.opacity(isAppeared ? 1 : 0)
				.onAppear() {
					withAnimation(.interpolatingSpring(stiffness: 70, damping: 12).delay(0.5)) {
						isAppeared = true
					}
				}
			
			Text("\(Text("SESSIYA") .font(.system(size: 28, weight: .black, design: .rounded)).foregroundStyle(.blue)) - это отдельная экосистема, которая помогает cтудентам которая превращает хаос семестра в спокойный стрик.")
				.font(.system(size: 22, weight: .semibold))
				.padding(.vertical, 70)
				.padding(.horizontal, 30)
				.offset(y: isAppeared ? 0 : 50)
						.opacity(isAppeared ? 1 : 0)
		}
	}
	
	private var buttontContainer: some View {
		VStack {
			Button {
				nextScreen.toggle()
			} label: {
				Text("Двигаемся дальше")
					.padding()
					
				Spacer()
				Image(systemName: "chevron.right")
					
			}
			.padding()
			.frame(minWidth: 400, minHeight: 50)
			.fontWeight(.semibold)
			.buttonStyle(.borderedProminent)
			
		}
		.padding()
	}
	
	
}

#Preview {
	StartingScreen()
}
