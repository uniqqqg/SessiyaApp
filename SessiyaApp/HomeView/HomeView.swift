//
//  HomeView.swift
//  SessiyaApp
//
//  Created by Глеб Моргунов on 29.11.25.
//

import SwiftUI
import HorizonCalendar

struct HomeView: View {
	
	@StateObject var viewModel = HomeViewModel()
	
	var body: some View {
		NavigationStack {
			VStack(alignment: .leading, spacing: 15) {
				welcomeView
				calendarView
				tasksView
			}
			.background(.gray.opacity(0.1))
			
			.sheet(isPresented: $viewModel.isPresentedScreen) {
				CalendarView()
			}
			.sheet(isPresented: $viewModel.isPresentedTask) {
				TaskView(viewModel: .init(), actionSave: { newTask in
					viewModel.addNewTask(newTask: newTask)
				})
			}
			
		}
	}
	
	private var welcomeView: some View {
		VStack(spacing: 105) {
			Text("Главная")
				.font(.title2)
				.fontWeight(.semibold)
				.foregroundStyle(.system)
			
			VStack(alignment: .leading, spacing: 10) {
				Text("\(manager.greeting)")
					.font(.system(size: 26))
					.fontWeight(.black	)
					.foregroundStyle(.system)
					.shadow(color: .gray, radius: 15, x: 0, y: 7)
				
				Text("Глеб")
					.font(.system(size: 22))
					.fontWeight(.light)
			}
			.frame(maxWidth: .infinity, alignment: .leading)
			.padding(.horizontal, 50)
		}
		
	}
	
	private var calendarView: some View {
		VStack(alignment: .center, spacing: .zero) {
			Button {
				viewModel.isPresentedScreen.toggle()
			} label: {
				Image(systemName: "calendar.badge.clock")
					.resizable()
					.scaledToFit()
					.frame(maxWidth: 30, maxHeight: 30)
					.frame(maxWidth: .infinity, alignment: .trailing)
					.padding(.horizontal, .zero)
					.foregroundStyle(.system)
			}
			RoundedRectangle(cornerRadius: 12)
				.foregroundStyle(.white)
				.frame(maxWidth: 400, maxHeight: 120)
				.shadow(color: .gray, radius: 7, x: 0, y: 10)
				.gesture(
					DragGesture()
						.onEnded { value in
							if value.translation.width < -50 {
								withAnimation {
									let nextWeek = Calendar.current.date(byAdding: .weekday, value: 7, to: viewModel.mondayOfWeek)!
									viewModel.selectedDate = nextWeek
								}
							}  else if value.translation.width > 50 {
								withAnimation {
									viewModel.selectedDate = Calendar.current.date(byAdding: .day, value: -7, to: viewModel.selectedDate)!
								}
							}
							
						}
				)
				.overlay(alignment: .top) {
					ZStack {
						VStack(spacing: 1) {
							HStack(spacing: 5) {
								Text("\(manager.now.day)")
									.font(.callout)
								Text("\(manager.now.monthName)")
									.font(.callout)
								
							}
							.frame(maxWidth: .infinity, alignment: .leading)
							.padding(5)
							ZStack {
								RoundedRectangle(cornerRadius: 23)
									.fill(Color.system.opacity(0.8))
									.frame(maxWidth: .infinity, maxHeight: 100)
									.frame( width: 52, height: 85)
									.offset(x: CGFloat(viewModel.selectedIndex) * viewModel.cellWidth - ( viewModel.cellWidth * 3))
									.animation(.spring(response: 0.4, dampingFraction: 0.8), value: viewModel.selectedIndex)
								
								
								
								VStack(spacing: 10) {
									HStack(spacing: 0) {
										ForEach(viewModel.dayNumbers.indices, id: \.self) {
											index in
											 let isToday = Calendar.current.isDateInToday(viewModel.weekDates[index])
											Text("\(viewModel.dayNumbers[index])")
												.frame(width: viewModel.cellWidth, height: 40)
												.font(.system(size: 18))
												.onTapGesture {
													viewModel.selectedDate = viewModel.weekDates[index]
												}
												.foregroundStyle(isToday ? .red : .black)
												.fontWeight(isToday ? .semibold : .medium)
											}
									}
									
									HStack(spacing: 0) {
										ForEach(viewModel.daysOfWeek, id: \.self) { days in
											Text("\(days)")
												.frame(width: viewModel.cellWidth, height: 30)
												.font(.system(size: 18))
												.foregroundStyle(.gray.opacity(0.9))
												.fontWeight(.semibold)
											
											
											
										}
									}
									
								}
								
								
							}
						}
					}
				}
		}
		.padding(.horizontal, 20)
	}
	
	private var tasksView: some View {
		VStack(spacing: 10) {
			HStack(spacing: .zero) {
				Text("Задачи на сегодня")
					.font(.title.bold())
				Spacer()
				Button {
					viewModel.isPresentedTask.toggle()
				} label: {
					Image(systemName: "plus.app")
						.resizable()
						.scaledToFit()
						.frame(width: 29, height: 29)
				}
				
			}
			.foregroundStyle(.system)
			.padding()
			
			ScrollView(.horizontal) {
				LazyHStack {
					ForEach(viewModel.tasks) { task in
						Button {
							
						} label: {
							TaskCellView(model: task)
								.padding()
						}
					}
					
				}
			}
			
		}
		.padding(.bottom, 150)
	}
}

#Preview {
	HomeView()
}
