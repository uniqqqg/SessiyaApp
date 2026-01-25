//
//  ColorSchemePublished.swift
//  SessiyaApp
//
//  Created by Глеб Моргунов on 10.01.26.
//

import Foundation
import SwiftUI
import Combine

class ColorSchemePublished: ObservableObject {
	@Published var theme: String = "system"

}
