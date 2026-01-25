//
//  NotificationView.swift
//  SessiyaApp
//
//  Created by Глеб Моргунов on 28.12.25.
//

import SwiftUI

struct NotificationView: View {
	@State var isOnToggle: Bool = false
    var body: some View {
		VStack {
			Toggle(isOn: $isOnToggle) {
				Text(" toggle ")
			}
			Spacer()
		}
		.padding()
		.navigationTitle("Уведомления и звуки")
		.navigationBarTitleDisplayMode(.inline)

    }
}

#Preview {
	NavigationStack {
		NotificationView()
	}
}
