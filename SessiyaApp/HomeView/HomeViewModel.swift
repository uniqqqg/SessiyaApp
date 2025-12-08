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
	@Published var selectedDate = Date()
	@Published var isPresentedTask: Bool = false
	var tasks: [TaskModel] = [TaskModel(title: "Математика", description: "Сделать дз до завтра", selectedTime: .now)]
	let cellWidth: CGFloat = 45
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
	
	func addNewTask(newTask: TaskModel) {
		withAnimation {
			tasks.append(newTask)
		}
	}
}

