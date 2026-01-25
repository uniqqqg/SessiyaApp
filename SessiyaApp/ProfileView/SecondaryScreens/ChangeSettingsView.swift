//
//  ChangeSettingsView.swift
//  SessiyaApp
//
//  Created by Глеб Моргунов on 28.12.25.
//

import SwiftUI

struct ChangeSettingsView: View {
	@State var isOn: Bool = false
    var body: some View {
		List {
			Section {
				Toggle("Settings", isOn: $isOn)
				Toggle("Settings", isOn: $isOn)
				Toggle("Settings", isOn: $isOn)

			}
			
			Section {
				Toggle("Settings", isOn: $isOn)
			}
		}
	}
}

#Preview {
	ChangeSettingsView()
}
