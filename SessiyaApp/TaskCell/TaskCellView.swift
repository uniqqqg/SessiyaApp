//
//  TaskCellView.swift
//  SessiyaApp
//
//  Created by Глеб Моргунов on 6.12.25.
//

import SwiftUI

struct TaskCellView: View {
	
	let model: TaskModel
	
    var body: some View {
		VStack(alignment: .leading, spacing: 0) {
			Text(model.title)
				.foregroundStyle(.white)
				.font(.system(size: 20))
				.lineLimit(2)
				.fontWeight(.semibold)
				.frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .topLeading)
				.padding()
			
			Text(model.description)
				.foregroundStyle(.white)
				.frame(maxWidth: .infinity, maxHeight: .infinity)
				.padding()
			
		}
		.frame(width: 150, height: 150)
		.background(.blue)
		.clipShape(.rect(cornerRadius: 16))
    }
}

#Preview {
	TaskCellView(model: .init(title: "Математика", description: "Сделать дз до завтра обазательно"))
}
