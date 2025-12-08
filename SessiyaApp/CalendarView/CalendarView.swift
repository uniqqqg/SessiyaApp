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
	
	var body: some View {
		DatePicker("select",
				   selection: $selectedDate,
				   displayedComponents: .date
		)
		.datePickerStyle(.graphical)
	}
}

#Preview {
    CalendarView()
}
