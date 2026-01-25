//
//  ProfileView.swift
//  SessiyaApp
//
//  Created by Глеб Моргунов on 27.11.25.
//

import SwiftUI
import PhotosUI

struct ProfileView: View {
	
	@StateObject var viewModel = ProfileViewModel()
	
	@Environment(\.dismiss) var dismiss
	@Environment(\.colorScheme) var colorScheme
	@AppStorage("name") var name = ""
	@AppStorage("photo") var photo: Data = Data()
	
	var body: some View {
		VStack(spacing: 10) {
			profileOfUserView
			Spacer()
			
		}
		.frame(maxWidth: .infinity, maxHeight: .infinity)
		.background(.gray.opacity(0.1))
		
		.navigationDestination(item: $viewModel.selectedScreenView) { screen in
			switch screen {
			case .editProfile: ProfileChangeView()
			case .editDesign: DesignView(settings: .init())
			case .editNotification: NotificationView()
			case .editSettings: ChangeSettingsView()
			}
		}

	}
	
	private var profileOfUserView: some View {
		VStack(spacing: 50) {
			Text("Профиль")
				.font(.title2)
				.fontWeight(.semibold)
				.foregroundStyle(.system)
			
			VStack(spacing: 10) {
				if viewModel.selectedImage == nil {
					Image(systemName: "person.crop.circle")
						.resizable()
						.scaledToFit()
						.foregroundStyle(.gray.opacity(0.6))
						.frame(width: 180, height: 180)
				} else  {
					viewModel.selectedImage?
						.resizable()
						.clipShape(.circle)
						.frame(width: 180, height: 180)
				}
				
				
				PhotosPicker("Выбрать фото", selection: $viewModel.selectedItem, matching: .images)
				
				
				Text(name.isEmpty ? "user" : name)
					.foregroundStyle(.primary)
					.font(.system(size: 28))
					.fontWeight(.medium)
			}
			
			.onChange(of: viewModel.selectedItem) { oldValue, newValue in
				Task {
					await viewModel.loadImage(from: newValue)
				}
			}
			
			List {
				Section {
					VStack(spacing: 10) {
						ForEach(viewModel.pairOfContainers.indices, id: \.self) { index
							in
							let pair = viewModel.pairOfContainers[index]
							Divider()

							HStack(spacing: 30) {
								Image(systemName: pair.0)
									.resizable()
									.scaledToFit()
									.frame(width: 30, height: 30)
									.foregroundStyle(.system)
								Button {
									switch index {
											case 0: viewModel.selectedScreenView = .editProfile
											case 1: viewModel.selectedScreenView = .editDesign
											case 2: viewModel.selectedScreenView = .editNotification
											case 3: viewModel.selectedScreenView = .editSettings
											default: break
											}
								} label: {
									Text(pair.1)
										.font(.system(size: 21))
								}
								.buttonStyle(.plain)
							}
							.frame(maxWidth: .infinity, alignment: .leading)
							
						}
						
					}
				}
			}

		}
	}
}

#Preview {
	NavigationStack {
		ProfileView()
	}
}
