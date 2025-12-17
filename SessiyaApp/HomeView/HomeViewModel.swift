//
//  HomeViewModel.swift
//  SessiyaApp
//
//  Created by Глеб Моргунов on 29.11.25.
//

import Foundation
import SwiftUI
import Combine

class HomeViewModel: ObservableObject {
	@Published var selectedNumber: Int = 0
	@Published var isPresentedScreen: Bool = false
	@Published var isPresentedAllTasksOfUserView: Bool = false
	@Published var selectedDate = Date()
	@Published var isPresentedTask: Bool = false
	@Published var selectedTask: TaskModel? = nil
	@Published var selectedDayForTask: String? = "Сегодня"
	@Published var tasks: [TaskModel] = [.init(title: "title", description: "desc", selectedTime: Calendar.current.date(byAdding: .day, value: 1, to: Date()) ?? .now), .init(title: "title2", description: "desc", selectedTime: Calendar.current.date(byAdding: .day, value: 2, to: Date()) ?? .now)]
	let nameDayForTasks: [String] = ["Сегодня","Неделя","Месяц"]
	
	var cellWidth: CGFloat {
		let screenWidth = UIScreen.main.bounds.width
		let horizontalPadding: CGFloat = 40
		return (screenWidth - horizontalPadding) / 7
	}
	let daysOfWeek: [String] = ["Пн", "Вт", "Ср", "Чт", "Пт", "Сб", "Вс"]
	var tickerTask: Task<Void, Never>?
	
	//нахождение понедельника
	var mondayOfWeek: Date {
		let weekday = Calendar.current.component(.weekday, from: selectedDate)
		let offset = weekday == 1 ? 6 : weekday - 2
		
		return Calendar.current.date(byAdding: .day, value: -offset, to: selectedDate)!
	}
	
	//7 дат недели
	var weekDates: [Date] {
		let calendar = Calendar.current
		return (0..<7).compactMap { offset in
			calendar.date(byAdding: .day, value: offset, to: mondayOfWeek)
		}
	}
	
	//числа для отображения
	var dayNumbers: [Int] {
		weekDates.map { date in
			Calendar.current.component(.day, from: date)
		}
	}
	
	var todayNumber: Int {
		Calendar.current.component(.day, from: Date())
	}
	
	var selectedIndex: Int {
		let weekday = Calendar.current.component(.weekday, from: selectedDate)
		return weekday == 1 ? 6 : weekday - 2
	}
	
	init() {
		tickerTask = Task { [weak self] in
			while !(Task.isCancelled) {
				await self?.updateNow()
				do {
					try await Task.sleep(for: .seconds(60))
				} catch {
					break
				}
			}
		}
	}
	
	@MainActor
	private func updateNow() async {
		DateManager.shared.now = Date()
	}
	
	func selectTask(task: TaskModel) {
		selectedTask = task
	}
	
	func save(task: TaskModel) {
		withAnimation {
			if let index = tasks.firstIndex(where: {$0.id == task.id }) {
				tasks[index] = task
			} else {
				tasks.append(task)
			}
		}
	}
	
	// MARK: - Filtering for "Сегодня / Неделя / Месяц
	var filteredTasksForSelectedRange: [TaskModel] {
		guard let selected = selectedDayForTask else { return tasks }
		let calendar = Calendar.current
		switch selected {
		case "Сегодня" :
				return tasks.filter { calendar.isDate($0.selectedTime, inSameDayAs: Date()) }
		case "Неделя":
			guard let weekInterval = calendar.dateInterval(of: .weekOfYear, for: Date()) else {
				return tasks
			}
			return tasks.filter { weekInterval.contains($0.selectedTime)}
		case "Месяц":
			guard let monthInterval = calendar.dateInterval(of: .month, for: Date()) else {
				return tasks
			}
			return tasks.filter { monthInterval.contains($0.selectedTime)}
		default:
			return tasks
		}
	}
	
}
