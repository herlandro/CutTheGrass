//
//  CutTHeGrassGameViewModel.swift
//  CutTHeGrass
//
//  Created by Herlandro Hermogenes on 20/03/2025.
//

import SwiftUI

struct CutTHeGrassGameView: View {
    @ObservedObject var viewModel = CutTHeGrassGameViewModel()
    
    // Computed property for avatar image from login
    var avatarImage: Image {
        if let data = UserDefaults.standard.data(forKey: "profileImage"),
           let uiImage = UIImage(data: data) {
            return Image(uiImage: uiImage)
        } else {
            return Image(systemName: "person.crop.circle.fill")
        }
    }
    
    var body: some View {
        NavigationView {
            ZStack {
                // Game background
                Color.green
                    .ignoresSafeArea()
                
                // Lawnmower image
                Image("lawnmower")
                    .resizable()
                    .frame(width: 50, height: 50)
                    .position(viewModel.mowerPosition)
                    .gesture(
                        DragGesture()
                            .onChanged { value in
                                viewModel.mowerPosition = value.location
                            }
                    )
                
                // Avatar button at top right
                VStack {
                    HStack {
                        Spacer()
                        Button(action: {
                            viewModel.didTapProfile()
                        }) {
                            avatarImage
                                .resizable()
                                .frame(width: 64, height: 64)
                                .clipShape(Circle())
                        }
                    }
                    Spacer()
                }
                .padding(.top, 16)
                .padding(.horizontal, 16)
                
                // NavigationLink to ProfileView
                NavigationLink(destination: ProfileView(), isActive: $viewModel.navigateToProfile) {
                    EmptyView()
                }
            }
            .navigationBarHidden(true)
            .onAppear {
                viewModel.startGameLoop()
            }
            .onDisappear {
                viewModel.stopGameLoop()
            }
        }
    }
}

#Preview {
    CutTHeGrassGameView()
}
