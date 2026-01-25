//
//  ProfileViewModel.swift
//  SessiyaApp
//
//  Created by Глеб Моргунов on 17.12.25.
//

import Foundation
import Combine
import PhotosUI
import SwiftUI

final class ProfileViewModel: ObservableObject {
	
	@Published var selectedItem: PhotosPickerItem?
	@Published var selectedImage: Image?
	@Published var selectedScreenView: Selections? = nil
	@AppStorage("photo") var photo: Data = Data()
	@Published var pairOfContainers = [
		(
			"pencil",
			"Изменить профиль"
		),
		(
			"circle.lefthalf.striped.horizontal",
			"Оформление"
		) ,
		(
			"bell.and.waveform.fill",
			"Уведомления и звуки"
		),
		(
			"gear",
			"Настройки"
		)
	]
	
	init() {
		if !photo.isEmpty,
			 let uiImage = UIImage(data: photo) {
				selectedImage = Image(uiImage: uiImage)
			}
	}
	
	func loadImage(from item: PhotosPickerItem?) async {
		guard let item = item else {
			selectedImage = nil
			return
		}
		
		if let data = try? await item.loadTransferable(type: Data.self),
		   let image = UIImage(data: data) {
			await MainActor.run {
				selectedImage = Image(uiImage: image)
				
			}
			if let compressedData = image.jpegData(compressionQuality: 0.8) {
				photo = compressedData
			}
		}
		
	}
	
	enum Selections {
		case editProfile
		case editDesign
		case editNotification
		case editSettings
	}
}
