//
//  CutTHeGrassGameView.swift
//  CutTHeGrass
//
//  Created by Herlandro Hermogenes on 20/03/2025.
//

import SwiftUI

struct CutTHeGrassGameView: View {
    @ObservedObject var viewModel = CutTHeGrassGameViewModel()
    @StateObject var trimmerViewModel = TrimmerViewModel()  // ViewModel para o Trimmer
    
    // Computed property for the avatar (login image)
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
            GeometryReader { geometry in
                // Define as margens internas
                let minX: CGFloat = 4
                let minY: CGFloat = 4
                let maxX = geometry.size.width - 4
                let maxY = geometry.size.height - 4
                
                ZStack {
                    // Background: Maze with grass
                    MazeView()
                    
                    // TrimmerView usando o TrimmerViewModel
                    TrimmerView(viewModel: trimmerViewModel)
                    
                    // Directional control pad positioned at the bottom left
                    VStack {
                        Spacer()
                        HStack {
                            DirectionPad { direction in
                                if direction == "cut" {
                                    viewModel.cut()  // Ação de corte permanece no viewModel do jogo
                                } else {
                                    trimmerViewModel.move(direction: direction)
                                }
                            }
                            Spacer()
                        }
                        .padding(.leading, 16)
                        .padding(.bottom, 16)
                    }
                    
                    // Avatar button at top right
                    VStack {
                        HStack {
                            Spacer()
                            Button(action: {
                                viewModel.didTapProfile()
                            }) {
                                avatarImage
                                    .resizable()
                                    .frame(width: 40, height: 40)
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
                // Limita a posição do trimmer para ficar dentro da área visível com margem de 4
                .onChange(of: trimmerViewModel.position) { newPosition in
                    let clampedX = min(max(newPosition.x, minX), maxX)
                    let clampedY = min(max(newPosition.y, minY), maxY)
                    if newPosition.x != clampedX || newPosition.y != clampedY {
                        trimmerViewModel.position = CGPoint(x: clampedX, y: clampedY)
                    }
                }
            }
            .navigationBarHidden(true)
        }
    }
}

struct CutTHeGrassGameView_Previews: PreviewProvider {
    static var previews: some View {
        CutTHeGrassGameView()
    }
}
