//
//  AddDataView.swift
//  SessiyaApp
//
//  Created by Глеб Моргунов on 27.11.25.
//

import SwiftUI
import Foundation

struct AddDataView: View {
	@State var imageFromInternet: UIImage?
	@State var errorMessage: String?
	@State var isLoading = false
	let url = URL(string: "https://fastly.picsum.photos/id/630/400/300.jpg?hmac=OYPhdznUm4AdKtxYjGXjvC_nkIwI7-Y05ULDlhNXkUM")
	let downloader = Downloader()
	
    var body: some View {
		VStack(spacing: 30) {
			Image(uiImage: imageFromInternet ?? UIImage(systemName: "person.crop.circle")!)
				.resizable()
				.scaledToFit()
				.frame(width: 150, height: 150)
			
				if errorMessage != nil {
						Text(" Ошибка: \(errorMessage!)")
				}
			
			Button {
				Task {
					do {
						imageFromInternet = try await downloader.fetchImage(from: url!.absoluteString)
					} catch {
						errorMessage = error.localizedDescription
					}
				}
			} label: {
				Text("Достать фото")
				
			}
			.buttonStyle(.bordered)
			.frame(maxWidth: .infinity)
			.foregroundStyle(.black)
		}
	}
}

#Preview {
	AddDataView()
}

class Downloader {
	
	var downloadedImage: UIImage?
	

	enum errors: Error {
		case invalidUrl
		case invalidData
		case invalidImage
	}
	func fetchImage(from url: String) async throws -> UIImage? {
		guard let url = URL(string: url) else {
			throw errors.invalidUrl
		}
		
		let (data,response) = try await URLSession.shared.data(from: url)
		
		guard let httpResponse = response as? HTTPURLResponse, httpResponse.statusCode == 200 else {
			throw errors.invalidData
		}
		
		guard let image = UIImage(data: data) else {
			throw errors.invalidImage
		}
		return image
	}
}


