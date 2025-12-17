//
//  TasksCellForAllDays.swift
//  SessiyaApp
//
//  Created by Глеб Моргунов on 11.12.25.
//

import SwiftUI

struct TasksCellForAllDays: View {
	
	let model: TaskModel
	
    var body: some View {
		HStack(spacing: 20) {
			Image(systemName: "flag.checkered")
				.resizable()
				.frame(width: 15, height: 15)
				.padding()
				.background(.white)
				.overlay {
					RoundedRectangle(cornerRadius: 16, style: .continuous)
						.stroke(style: .init(lineWidth: 1))
				}
				.clipShape(.rect(cornerRadius: 16))
			VStack(spacing: 10) {
				Text(model.title)
					.fontWeight(.bold)
					.frame(maxWidth: .infinity, alignment: .leading)
				
				Text("\(model.selectedTime, format: .dateTime.hour().minute()) ")
					.frame(maxWidth: .infinity, alignment: .leading)
			}
		}
		.padding()
		.frame(maxWidth: .infinity, alignment: .leading)
		.background(Color.random.opacity(0.3))
		.lineLimit(1)
		.overlay {
			RoundedRectangle(cornerRadius: 20, style: .continuous)
				.stroke(style: .init(lineWidth: 1))
		}
		.clipShape(.rect(cornerRadius: 20))
		.padding(.horizontal, 30)

    }
}

#Preview {
	TasksCellForAllDays(model: .init(title: "Плашка дизайн", description: ""))
}
