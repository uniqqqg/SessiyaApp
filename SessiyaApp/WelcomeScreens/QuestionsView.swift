//
//  QuestionsView.swift
//  SessiyaApp
//
//  Created by Глеб Моргунов on 22.11.25.
//

import SwiftUI

struct QuestionsView: View {
	@State private var isPresented: Bool = false
	@State private var currentPage: Int = 0
	@State private var answers: [String?] = Array(repeating: nil, count: 3)
	@State private var image: String = "puple"
	@State private var option: [String] = ["puple"]

	
	 private var canGoNext: Bool {
		answers[currentPage] != nil
	}

	private let questions1 = [
		"Не пропускать пары",
		"Делать конспекты вовремя",
		"Готовиться к сессии заранее",
		"Учить английский / программирование"
	]
	private let questions2 = [
		"30–60 минут в день",
		"1–2 часа в день",
		"2–4 часа в день",
		"4+ часа — я машина"
	]
	private let questions3 = [
		"1–2 привычки в день",
		"3–5 привычек — нормально",
		"6–8 привычек — хардкор",
		"Думаю, мне не нужны хорошие привычки)"
	]

	var allQuestions: [OnboardingQuestion] {
		[
			
			OnboardingQuestion(imageName: "puple2", options: questions1),
			OnboardingQuestion(imageName: "puple3", options: questions2),
			OnboardingQuestion(imageName: "puple4", options: questions3)
		]
	}
	
	var body: some View {
		NavigationStack {
			VStack(spacing: .zero) {
				TabView(selection: $currentPage) {
					ForEach(allQuestions.indices, id: \.self) { index in
						QuestionCardView(question: allQuestions[index], selectedOption: $answers[index])
					}
				}
				.tabViewStyle(.page(indexDisplayMode: .never))
				.indexViewStyle(.page(backgroundDisplayMode: .always))
				
				Button {
					if currentPage < allQuestions.count - 1 {
						withAnimation { currentPage += 1 }
					}
					else  {
						isPresented = true
					}
				} label: {
					Text( currentPage == allQuestions.count - 1 ? "Готово" : "Следующий вопрос")
						.padding()
						.font(.title3.bold())
						.foregroundColor(.white)
						.frame(maxWidth: .infinity)
						.frame(height: 55)
						.background(
							Capsule()
								.fill(canGoNext ? Color.blue : Color.gray.opacity(0.5))
						)
				}
				.disabled(!canGoNext)
				.padding()
				
				
			}
			
			HStack {
				ForEach(0..<allQuestions.count, id: \.self) { i in
					Circle()
						.fill(i == currentPage ? .white : .white.opacity(0.4))
						.frame(width: 20, height: 13)
						.scaleEffect(i == currentPage ? 1.2 : 1.0)
						.animation(.easeInOut, value: currentPage)
				}
			}
			.frame(height: 20)
			.background(
				RoundedRectangle(
					cornerRadius: 10
				)
				.fill(.gray)
			)
			.padding()
			
			.navigationDestination(isPresented: $isPresented) {
				BenefitsForUserView()
			}
			
			.navigationBarBackButtonHidden(true)
			
		}
	}
}

struct QuestionCardView: View {
	
	let question: OnboardingQuestion
	@Binding var selectedOption: String?
	
	var body: some View {
		VStack(spacing: 10) {
			Image(question.imageName)
				.resizable()
				.scaledToFit()
				.frame(width: 400, height: 400)
			
			
			LazyVGrid(columns: [GridItem(.flexible()), GridItem(.flexible())], spacing: 20) {
				
				ForEach(question.options, id: \.self) { text in
					Button {
						selectedOption = text
					} label: {
						Text("\(text)")
							.frame(width: 165, height: 130)
							.fontWeight(.semibold)
							.foregroundStyle(.white)
					}
					
					.background(
						RoundedRectangle(cornerRadius: 20)
							.fill(selectedOption == text ? .blue.opacity(0.7) : .gray.opacity(0.5))
							.shadow(color: .black.opacity(0.7), radius: 8, x: 0, y: 4)
						
					)
				}
			}
			.padding(.bottom, 100)
			
		}
	}
	
	
}

#Preview {
	QuestionsView()
}
