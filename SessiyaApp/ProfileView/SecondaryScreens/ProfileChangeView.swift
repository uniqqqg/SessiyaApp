//
//  ProfileChangeView.swift
//  SessiyaApp
//
//  Created by Глеб Моргунов on 28.12.25.
//

import SwiftUI

struct ProfileChangeView: View {
	@AppStorage("name") var name: String = ""
	@AppStorage("surname") var surname: String = ""
	@AppStorage("email") var email: String = ""
	@State var birthday: Date = Date()
	@State private(set) var userData: [UserData] = []
	@State private var userDataModel: UserData = .init()
	@Environment(\.dismiss) var dismiss

	func addUserData() {
		userDataModel.name = name
		userDataModel.surname = surname
		userDataModel.birthday = birthday
	}

    var body: some View {
		VStack {
			nameSection
			Spacer()
		}
		
			.navigationTitle("Редактирование профиля")
			.navigationBarTitleDisplayMode(.inline)
			.navigationBarBackButtonHidden(true)
    }
	
	private var nameSection: some View {
		VStack(spacing: 0) {
			Section {
				TextField("Введите имя", text: $name)
					.padding()
					.frame(width: .infinity, height: 50)
					.background(
						RoundedRectangle(cornerRadius: 30).stroke(.system)
					)
				
				TextField("Введите фамилию", text: $surname)
					.padding()
					.frame(width: .infinity, height: 50)
					.background(
						RoundedRectangle(cornerRadius: 30).stroke(.system)
					)
				
				TextField("Введите почту", text: $email)
					.padding()
					.frame(width: .infinity, height: 50)
					.background(
						RoundedRectangle(cornerRadius: 30).stroke(.system)
					)
				DatePicker("Выберите дату рождения", selection: $birthday)
					.padding()
					.frame(width: .infinity, height: 80)
					.background(
						RoundedRectangle(cornerRadius: 30).stroke(.system)
					)
				
			}
			.padding()
			
			Spacer()
			
			Button {
				addUserData()
				dismiss()
			} label: {
				Text("Сохранить")
					.frame(maxWidth: .infinity, maxHeight: 50)
			}
			.padding()
			.buttonStyle(.borderedProminent)
		}
	}
}

#Preview {
	NavigationStack {
		ProfileChangeView( )
	}
}
