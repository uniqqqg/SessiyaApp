//
//  CalendarView.swift
//  SessiyaApp
//
//  Created by Глеб Моргунов on 30.11.25.
//

import SwiftUI
import HorizonCalendar

struct CalendarView: View {
	
	@State var selectedDate = Date()
	@Environment(\.dismiss) var dismiss
	var selectDay: (Date) -> Void
	
	init(selectedDate: Date = Date(), selectDay: @escaping (Date) -> Void) {
		_selectedDate = State(initialValue: selectedDate)
		self.selectDay = selectDay
	}
	
	var body: some View {
		VStack {
			DatePicker("select",
					   selection: $selectedDate,
					   displayedComponents: .date
			)
			.datePickerStyle(.graphical)
			
			Spacer()
			
			buttonContainer
		}
		.padding()
	}
	
	private var buttonContainer: some View {
		VStack(spacing: .zero) {
			Button {
				selectDay(selectedDate)
				dismiss()
			} label: {
				Text("Выбрать число")
					.frame(maxWidth: .infinity, minHeight: 50)
			}
			.padding()
			.buttonStyle(.borderedProminent)
		}
	}
}

#Preview {
	CalendarView( selectDay: { _ in })
}
