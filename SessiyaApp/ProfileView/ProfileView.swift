//
//  ProfileView.swift
//  SessiyaApp
//
//  Created by Глеб Моргунов on 27.11.25.
//

import SwiftUI

struct ProfileView: View {
	
	@StateObject var viewModel = ProfileViewModel()
	
	init(viewModel: ProfileViewModel) {
	_viewModel = StateObject(wrappedValue: viewModel)
	}
	
    var body: some View {
		Text("Hello, Profile!")
    }
}

#Preview {
	ProfileView(viewModel: .init())
}
