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
			VStack(alignment: .leading, spacing: 25) {
				welcomeView
				calendarView
				tasksView
				allTasksOfUserView
			}
			.frame(maxHeight: .infinity)
			.background(.gray.opacity(0.1))
			
			.sheet(isPresented: $viewModel.isPresentedScreen) {
				CalendarView(selectedDate: viewModel.selectedDate, selectDay: { newDate in
					viewModel.selectedDate = newDate
				})
			}
			
			.sheet(isPresented: $viewModel.isPresentedTask) {
				TaskView(viewModel: TaskViewModel(), actionSave: { newTask in
					viewModel.save(task: newTask)
				})
			}
			
			.navigationDestination(item: $viewModel.selectedTask) { task in
				TaskView(
					viewModel: TaskViewModel(task: task, configuration: .edit),
					actionSave: { newTask in
							viewModel.save(task: newTask)
						
						let taskDay = Calendar.current.startOfDay(for: newTask.selectedTime)
						
						viewModel.selectedDate = taskDay
					})
			}
			
 		}
	}
	
	private var welcomeView: some View {
		VStack(spacing: 15) {
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
			.frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .leading)
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
					.frame(width: 30, height: 30)
					.frame(maxWidth: .infinity, alignment: .trailing)
					.padding(.horizontal, .zero)
					.foregroundStyle(.system)
			}
			RoundedRectangle(cornerRadius: 12)
				.foregroundStyle(.white)
				.frame(maxWidth: .infinity, minHeight: 130, maxHeight: 130)
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
									.frame(maxHeight: 90)
									.frame(width: viewModel.cellWidth - 8,height: 90)
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
												
												.overlay { isToday ?
													RoundedRectangle(
														cornerRadius: 20,
														style: .continuous
													)
													.stroke(
														Color.system,
														style: .init(
															lineWidth: 2
														)
													)
													.frame(width: viewModel.cellWidth - 8,height: 90)
													.padding(.top, 40)
													: RoundedRectangle(
														cornerRadius: 6,
														style: .continuous
													)
													.stroke(Color.clear,
															style: .init(
																lineWidth: 1
															)
													)
													.frame(width: viewModel.cellWidth - 8, height: 50)
													.padding(.top, 10)
												}	.fontWeight(isToday ? .semibold : .medium)
										}
									}
									
									HStack(spacing: 0) {
										ForEach(viewModel.daysOfWeek, id: \.self) { days in
											Text("\(days)")
												.frame(width: viewModel.cellWidth, height: 30)
												.font(.system(size: 18))
												.foregroundStyle(.black)
												.fontWeight(.light)
											
											
											
										}
									}
									
								}
								.frame(maxWidth: .infinity)
								
							}
						}
					}
				}
		}
		.frame(maxWidth: .infinity)
		.padding(.horizontal, 20)
	}
	
	private var tasksView: some View {
		VStack(spacing: 5) {
			HStack(spacing: .zero) {
				Text("Задачи на \(viewModel.selectedDate.formatted(.dateTime.day().month(.wide)))")
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
			.padding(.horizontal)
			.foregroundStyle(.system)
			
			ScrollView(.horizontal) {
				
				let sortedTasks = viewModel.tasks.filter { task in Calendar.current.isDate(viewModel.selectedDate, inSameDayAs: task.selectedTime) }
				
				if sortedTasks.isEmpty {
					VStack {
						ContentUnavailableView(
							"Нет задач",
							systemImage: "list.bullet.rectangle",
							description: Text("Нажми + чтобы добавить первую задачу")
						)
						.padding()
					}
				} else {
					VStack(spacing: .zero) {
						LazyHStack(spacing: 10) {
							ForEach(sortedTasks, id: \.self) { task in
								Button {
									withAnimation {
										viewModel.save(task: task)
										viewModel.selectTask(task: task)
									}
								} label: {
									TaskCellView(model: task)
								}
							}
						}
						.padding(.horizontal)
					}
				}
			}
			
		}
		.frame(height: 200)
	}
	
	private var allTasksOfUserView: some View {
		VStack(spacing: .zero) {
			HStack(spacing: 10) {
				ForEach(viewModel.nameDayForTasks, id: \.self) { button in
					Button {
						withAnimation(.easeIn) {
							viewModel.selectedDayForTask = button
						}
					} label: {
						Text(button)
							.foregroundStyle(viewModel.selectedDayForTask == button ? .system : .system.opacity(0.5))
							.font(.system(size: 24))
							.fontWeight(.semibold)
					}
					.buttonStyle(.plain)
					.frame(maxWidth: .infinity)
				}
			}
			.padding(.bottom, 50)
			.frame(maxWidth: .infinity, maxHeight: 40)
			
			ScrollView(.vertical) {
				LazyVStack(spacing: 10) {
					let sortedTasks = viewModel.filteredTasksForSelectedRange.sorted { $0.selectedTime < $1.selectedTime}
					if sortedTasks.isEmpty {
						ContentUnavailableView("Пусто", systemImage: "list.bullet.rectangle", description: Text(""))
								.foregroundStyle(.gray)
								
					} else {
						ForEach(viewModel.filteredTasksForSelectedRange) { task in
							withAnimation(.snappy) {
								Button {
									viewModel.selectTask(task: task)
								} label: {
									TasksCellForAllDays(model: task)
								}
								.buttonStyle(.plain)
							}
						}
					}
					
				}
			}
		}
	}
}

#Preview {
	HomeView()
}


