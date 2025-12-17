//
//  TaskView.swift
//  SessiyaApp
//
//  Created by Глеб Моргунов on 4.12.25.
//

import SwiftUI

struct TaskView: View {
	
	@StateObject var viewModel: TaskViewModel
	var actionSave: (_ newTask: TaskModel) -> Void
	@Environment(\.dismiss) var dismiss
	
	init(viewModel: TaskViewModel, actionSave: @escaping (_ newTask: TaskModel) -> Void) {
		_viewModel = StateObject(wrappedValue: viewModel)
		self.actionSave = actionSave
	}
	
    var body: some View {
		sectionContainer
		Spacer()
		buttonContainer
    }
	
	private var sectionContainer: some View {
		List {
				Section("Задача") {
					TextField("Введите название", text: $viewModel.title)
						.font(.system(size: 20))
						.lineLimit(1...10)
					
				}
				
				Section("Описание") {
					TextField("Введите описание", text: $viewModel.description, axis: .vertical)
						.font(.system(size: 20))
						.frame(height : 200, alignment: .top)
					
				}
				
			DatePicker("Время", selection: $viewModel.selectedTime)
				.foregroundStyle(.black)
		}
			.fontWeight(.semibold)
			.font(.system(size: 28))
	}
	
	private var buttonContainer: some View {
		VStack(spacing: .zero) {
			
			Button {
				viewModel.onSave()
				actionSave(viewModel.taskModel)
				dismiss()
			} label: {
				Text(viewModel.configuration == .create ? "Создать задачу" : "Сохранить изменения")
					.frame(maxWidth: .infinity, maxHeight: 50)

			}
			.disabled(viewModel.isSaveDisabled)
			.padding()
			.buttonStyle(.borderedProminent)
			
		}
	}
}

#Preview {
	TaskView(viewModel: .init(), actionSave: { _ in })
}
