//
//  ModePickerView.swift
//  SessiyaApp
//
//  Created by Глеб Моргунов on 24.01.26.
//

import SwiftUI

struct ModePickerView: View {
	
	private var buttonNameSection: [String] = ["Focus", "Short Break", "Long Break"]
	@State var selectedButton: String = "Focus"
	
    var body: some View {
			VStack(spacing: 10) {
				HStack(spacing: 20) {
					ForEach(buttonNameSection, id: \.self) { name in
						Button {
							selectedButton = name
						} label: {
							Text(name)
								.foregroundStyle(.white)
								.font(.system(size: 15))
								.fontWeight(.semibold)
						}
						.frame(width: 90, height: 50)
						.background(selectedButton == name ? .blue.opacity(0.3) : .system)
						.clipShape(RoundedRectangle(cornerRadius: 20))
						.shadow(radius: 20)
					}
				}
			
				
			}
    }
}

#Preview {
    ModePickerView()
}
