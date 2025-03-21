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
    
    func didTapProfile() {
        navigateToProfile = true
    }
    
    func cut() {
        print("Cutting grass")
    }
}
