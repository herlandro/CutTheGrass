//
//  Trimmer.swift
//  CutTHeGrass
//
//  Created by Herlandro Hermogenes on 20/03/2025.
//

import SwiftUI

struct Trimmer: Identifiable, Codable {
    let id: UUID = UUID()
    var imageName: String
    var positionX: CGFloat
    var positionY: CGFloat
    
    // Computed property to get CGPoint from positionX and positionY
    var position: CGPoint {
        CGPoint(x: positionX, y: positionY)
    }
    
    init(imageName: String, position: CGPoint) {
        self.imageName = imageName
        self.positionX = position.x
        self.positionY = position.y
    }
}
