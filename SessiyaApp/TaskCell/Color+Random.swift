//
//  Color+Random.swift
//  SessiyaApp
//
//  Created by Глеб Моргунов on 11.12.25.
//

import SwiftUI

extension Color {
	static var random: Color {
		Color(
			red: .random(in: 0...1),
			green: .random(in: 0...1),
			blue: .random(in: 0...1),
		)
	}
}
