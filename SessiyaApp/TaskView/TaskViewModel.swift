//
//  TaskViewModel.swift
//  SessiyaApp
//
//  Created by Глеб Моргунов on 4.12.25.
//

import Foundation
import Combine

final class TaskViewModel: ObservableObject {
	@Published var title: String = ""
	@Published var description: String = ""
 	@Published var selectedDate = Date()
	private(set) var taskModel: TaskModel = .init(title: "", description: "")
	
	func onSave() {
		taskModel = .init(title: title, description: description, selectedTime: selectedDate)
	}
	
}

