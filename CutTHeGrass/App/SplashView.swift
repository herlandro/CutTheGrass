//
//  SplashView.swift
//  CutTHeGrass
//
//  Created by Herlandro Hermogenes on 20/03/2025.
//

import SwiftUI

struct SplashView: View {
    @State private var isActive = false
    
    var body: some View {
        if isActive {
            LoginView()
        } else {
            ZStack {
                Image("trimmer_1")
                    .resizable()
                    .scaledToFill()
                    .ignoresSafeArea()

                    OutlinedText(text: "Cut The\nGrass",
                                 font: UIFont(name: "MarkerFelt-Wide", size: 72)!,
                                 textColor: .white,
                                 strokeColor: .black,
                                 strokeWidth: -2.0)

                
                
            }
            .onAppear {
                // Após 2 segundos, muda para a tela de login
                DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
                    withAnimation {
                        isActive = true
                    }
                }
            }
        }
    }
}

struct SplashView_Previews: PreviewProvider {
    static var previews: some View {
        SplashView()
    }
}
