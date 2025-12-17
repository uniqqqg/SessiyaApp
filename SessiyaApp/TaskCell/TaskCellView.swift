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
        VStack(alignment: .leading, spacing: 25) {
            Text(model.title)
                .font(.system(size: 18))
                .fontWeight(.semibold)

            Text("\(model.selectedTime, format: .dateTime.hour().minute())")
                .font(.subheadline)

            Text(model.description)
                .font(.caption)
        }
        .padding()
        .foregroundStyle(.black)
        .frame(width: 120, height: 140, alignment: .leading)
		.background(Color.random.opacity(0.3))
        .lineLimit(2)
		.overlay(
			RoundedRectangle(cornerRadius: 16, style: .continuous)
				.stroke(Color.black.opacity(0.25), lineWidth: 2)
		)
        .clipShape(.rect(cornerRadius: 16))
    }
}

#Preview {
	TaskCellView(model: .init(title: "", description: ""))
}
