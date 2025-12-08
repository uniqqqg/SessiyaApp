//
//  BenefitsForUserView.swift
//  SessiyaApp
//
//  Created by Глеб Моргунов on 24.11.25.
//

import SwiftUI

struct BenefitsForUserView: View {
	
	@State private var currentPage: Int = 0
	@State private var amountOfPages: Int = 4
	@State private var disabled: Bool = false
	@State private var lastPage: Bool = false
	@State private var isPresented: Bool = false
	
	func setupAppearance() {
	   UIPageControl.appearance().currentPageIndicatorTintColor = .black
	   UIPageControl.appearance().pageIndicatorTintColor = UIColor.black.withAlphaComponent(0.2)
	 }
	
	func nextPage() {
		if currentPage == amountOfPages - 1 {
			isPresented = true
		} else {
			currentPage += 1
		}
	}
	
	
	
	
	private var cardTextMain: [String] = [
		"За 2 недели ты перестанешь пропускать пары",
		"Сессия без паники и ночных зачётов ",
		"Ты наконец-то начнёшь учить английский/программирование/другие предметы",
		"«Твои родители перестанут орать» "
	]
	private var cardTextSecondary: [String] = [
		" 94 % студентов, которые вели стрики, повысили посещаемость с 62 % до 96 %",
		" Мы сами напомним, что нужно сдать, и покажем, сколько осталось дней",
		" 5 минут в день = 300+ часов за год. Люди, которые ставили привычки в Sessiya, акрывали B2 за семестр и становились специалистами Junior",
		"средний балл студентов вырос с 3.8 до 4.6 за один семестр"
	]
	var body: some View {
		TabView(selection: $currentPage) {
			ForEach(cardTextMain.indices, id: \.self) { index in
				VStack(spacing: 40) {
					Text("\(cardTextMain[index])")
						.font(.title2.bold())
						.foregroundStyle(.white)
						.multilineTextAlignment(.center)
					
					Text("\(cardTextSecondary[index])")
						.font(.title3)
						.foregroundStyle(.white.opacity(0.85))
						.multilineTextAlignment(.center)
						.lineSpacing(6)
					
					Spacer()
				}
				.padding(.top, 100)
				
			}
			.padding(.horizontal, 40)
			.padding(.vertical, 80)
			.frame(maxWidth: .infinity, maxHeight: .infinity)
			.background(
				RoundedRectangle(cornerRadius: 32, style: .continuous)
					.fill(Color.black.opacity(0.28))
					.overlay(
						RoundedRectangle(cornerRadius: 32, style: .continuous)
							.stroke(Color.white.opacity(0.15), lineWidth: 1)
					)
					.shadow(color: .black.opacity(0.4), radius: 20, y: 10)
			)
			.padding(.horizontal, 24)
			.padding(.vertical, 40)
			
			
			
		}
		
		.tabViewStyle(.page(indexDisplayMode: .always))
		.onAppear {
			setupAppearance()
		}
		
		Button {
			nextPage()
		} label: {
			Image(systemName: "arrowshape.forward.circle.fill")
				.resizable()
				.frame(width: 30, height: 30)
				.foregroundStyle(.black)
		}
		
		
		.navigationBarHidden(true)
		.navigationBarBackButtonHidden(true)
		.navigationDestination(isPresented: $isPresented) {
			MainView()
		}
	}
	
	
	} //comment

	


#Preview {
	NavigationStack {
		BenefitsForUserView()
	}
}
