//
//  TrimmelViewModel.swift
//  CutTHeGrass
//
//  Created by Herlandro Hermogenes on 20/03/2025.
//
 
import SwiftUI

class TrimmerViewModel: ObservableObject {
    @Published var position: CGPoint = CGPoint(x: 100, y: 100)
    @Published var image: Image = Image(systemName: "person.crop.circle.fill")
    
    init(position: CGPoint = CGPoint(x: 100, y: 100), image: Image = Image(systemName: "person.crop.circle.fill")) {
        self.position = position
        self.image = image
    }
    
    func updatePosition(to newPosition: CGPoint) {
        self.position = newPosition
    }
    
    // Novo método para mover o trimmer com base na direção
    func move(direction: String) {
        let delta: CGFloat = 10
        switch direction {
        case "up":
            updatePosition(to: CGPoint(x: position.x, y: position.y - delta))
        case "down":
            updatePosition(to: CGPoint(x: position.x, y: position.y + delta))
        case "left":
            updatePosition(to: CGPoint(x: position.x - delta, y: position.y))
        case "right":
            updatePosition(to: CGPoint(x: position.x + delta, y: position.y))
        case "upLeft":
            updatePosition(to: CGPoint(x: position.x - delta, y: position.y - delta))
        case "upRight":
            updatePosition(to: CGPoint(x: position.x + delta, y: position.y - delta))
        case "downLeft":
            updatePosition(to: CGPoint(x: position.x - delta, y: position.y + delta))
        case "downRight":
            updatePosition(to: CGPoint(x: position.x + delta, y: position.y + delta))
        default:
            break
        }
    }
}

