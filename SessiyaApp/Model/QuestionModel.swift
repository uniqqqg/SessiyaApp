//
//  QuestionModel.swift
//  SessiyaApp
//
//  Created by Глеб Моргунов on 23.11.25.
//

import Foundation

struct OnboardingQuestion {
	let id = UUID()
	var imageName: String
	var options: [String]
	
	init( imageName: String, options: [String]) {
		self.imageName = imageName
		self.options = options
	}
}
