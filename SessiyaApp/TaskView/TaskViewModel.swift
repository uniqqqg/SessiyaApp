//
//  TaskViewModel.swift
//  SessiyaApp
//
//  Created by Глеб Моргунов on 4.12.25.
//

import Foundation
import Combine

final class TaskViewModel: ObservableObject {
	@Published var title: String
	@Published var description: String
	@Published var selectedTime: Date = Date()
	let configuration: Configuration
	var isSaveDisabled: Bool {
		title.isEmpty || description.isEmpty
	}
	private(set) var taskModel: TaskModel = .init(title: "", description: "")
	
	func onSave() {
		taskModel.title = title
			   taskModel.description = description
			   taskModel.selectedTime = selectedTime
	}
	
	enum Configuration {
		case create
		case edit
	}

	init(task: TaskModel, configuration: Configuration ) {
		self.title = task.title
		self.description = task.description
		self.selectedTime = task.selectedTime
		self.configuration = configuration
		self.taskModel = task
	}
	//зачем и как равботаю два инит
	init() {
		let task = TaskModel(title: "", description: ""	)
		self.title = ""
		self.description = ""
		self.selectedTime = Date()
		self.taskModel = task
		self.configuration = .create
		}
	
}
	
