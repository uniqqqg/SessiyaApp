//
//  ControlButton.swift
//  SessiyaApp
//
//  Created by Глеб Моргунов on 24.01.26.
//

import SwiftUI

struct ControlButton: View {
	var body: some View {
		iconForButton
	}
	private var iconForButton: some View {
		VStack(spacing: 10) {
			HStack(spacing: 10) {
				buttonAction(icon: "arrow.trianglehead.counterclockwise", size: 40, iconSize: 25, foreColor: .white, backColor: Color.gray.opacity(0.7))
				
				buttonAction(icon: "play.fill", size: 80, iconSize: 40,foreColor: .white, backColor: Color.gray.opacity(0.3))
				buttonAction(icon: "text.insert", size: 40, iconSize: 25,foreColor: .white, backColor: Color.gray.opacity(0.7))
			}
			
			Text("Completed sessions: ")
				.foregroundStyle(.primary)
				.font(.subheadline)
				.fontWeight(.semibold)
		}
	}
	
	@ViewBuilder
	private func buttonAction( icon: String, size: CGFloat, iconSize: CGFloat,foreColor: Color, backColor: Color, isPrimary: Bool = false) -> some View {
		VStack(spacing: .zero) {
			Button {
				
			} label: {
				
			}
			.frame(width: size, height: size )
			.overlay {
				Circle()
					.fill(backColor)
				
				Image(systemName: icon)
					.resizable()
					.scaledToFit()
					.frame(width: iconSize, height: iconSize)
					.foregroundStyle(foreColor)
			}
		}
	}
}
#Preview {
    ControlButton()
}
