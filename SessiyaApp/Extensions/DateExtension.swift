//
//  DateExtension.swift
//  SessiyaApp
//
//  Created by Глеб Моргунов on 30.11.25.
//

import Foundation

extension Date {
	var day: Int { Calendar.current.component(.day, from: self) } //возвращает день(число) месяца
	var month: Int { Calendar.current.component(.month, from: self) }//возвращает месяц текущий
	var year: Int { Calendar.current.component(.year, from: self) }//возвращает год текущий
	var weekday: Int { Calendar.current.component(.weekday, from: self) }
	var dayOfMonth: Int { DateManager.shared.now.day } //
	var dayOfWeek: String { DateManager.shared.now.monthName }
	
	var monthName: String {
		Calendar.current.monthSymbols[month - 1]
	}
	var weekdayName: String {
			Calendar.current.weekdaySymbols[weekday - 1]
		}
		
	var shortWeekdayName: String {
			Calendar.current.shortWeekdaySymbols[weekday - 1]
		}
	
	
	
	var range: Range<Int>? {
		Calendar.current.range(of: .day, in: .month, for: Date.now)
	}
	
	
	
}
