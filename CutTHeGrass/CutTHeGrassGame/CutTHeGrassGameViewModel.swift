//
//  CutTHeGrassGameViewModel.swift
//  CutTHeGrass
//
//  Created by Herlandro Hermogenes on 20/03/2025.
//

import SwiftUI

class CutTHeGrassGameViewModel: ObservableObject {
    @Published var mowerPosition: CGPoint = CGPoint(x: 100, y: 100)
    @Published var navigateToProfile: Bool = false
    
    private var gameTimer: Timer?
    
    func startGameLoop() {
        gameTimer = Timer.scheduledTimer(withTimeInterval: 0.016, repeats: true) { _ in
            DispatchQueue.main.async {
                // Example game logic: move the lawnmower continuously to the right
                self.mowerPosition.x += 1
            }
        }
    }
    
    func stopGameLoop() {
        gameTimer?.invalidate()
        gameTimer = nil
    }
    
    func didTapProfile() {
        navigateToProfile = true
    }
}

