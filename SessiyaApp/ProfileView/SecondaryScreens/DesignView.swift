//
//  DesignView.swift
//  SessiyaApp
//
//  Created by Глеб Моргунов on 28.12.25.
//

import SwiftUI

struct DesignView: View {
	
	@StateObject var settings: ColorSchemePublished
	init(settings: ColorSchemePublished) {
		_settings = StateObject(wrappedValue: settings)
	}
	
	var body: some View {
		List {
			Picker("Тема", selection: $settings.theme) {
				Text("Светлая").tag("light")
				Text("Тёмная").tag("dark")
				Text("Системная").tag("system")

			}
			.pickerStyle(.segmented)
		}
			.navigationTitle("Настройка темы")
			.navigationBarTitleDisplayMode(.inline)
	}
}

#Preview {
	NavigationStack {
		DesignView(settings: .init())
	}
}
