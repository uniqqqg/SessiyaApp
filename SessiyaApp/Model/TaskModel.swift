//
//  NewTaskModel.swift
//  SessiyaApp
//
//  Created by Глеб Моргунов on 5.12.25.
//

import Foundation

struct TaskModel: Identifiable {
	var id = UUID()
	var title: String
	var description: String
	var selectedTime = Date()
	
	init(title: String, description: String, selectedTime: Date = Date()) {
		self.title = title
		self.description = description
		self.selectedTime = selectedTime
	}
}
