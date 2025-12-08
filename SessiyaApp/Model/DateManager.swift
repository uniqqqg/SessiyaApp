//
//  DateManager.swift
//  SessiyaApp
//
//  Created by Глеб Моргунов on 30.11.25.
//

import Foundation

final class DateManager {
	static let shared = DateManager()
	
	var now: Date = Date()
	
	var greeting: String {
		let hour = Calendar.current.component(.hour, from: now)
		switch hour {
		case 6..<12:
			return "Доброе утро "
		case 12..<18:
			return "Добрый день "
		case 18..<23:
			return "Добрый вечер "
		default:
			return "Доброй ночи "
		}
	}
}

let manager = DateManager()
