//
//  MazeView.swift
//  CutTHeGrass
//
//  Created by Herlandro Hermogenes on 20/03/2025.
//

import SwiftUI

import SwiftUI

// MazeView representing the labyrinth and grass
struct MazeView: View {
    let rows: Int = 10
    let columns: Int = 10
    // Simula um labirinto: células onde (row+col) % 4 == 0 são paredes; as demais são grama.
    // Para demonstração, a grama não "cortada" é verde, e quando cortada (simulado com isCut == true)
    // ficaria verde claro. Aqui, para simplificação, isCut é sempre false.
    var body: some View {
        GeometryReader { geometry in
            let cellWidth = geometry.size.width / CGFloat(columns)
            let cellHeight = geometry.size.height / CGFloat(rows)
            ForEach(0..<rows, id: \.self) { row in
                ForEach(0..<columns, id: \.self) { col in
                    let isWall = ((row + col) % 4 == 0)
                    let isCut = false // Lógica para verificar se a grama foi cortada
                    let color: Color = isWall ? .gray : (isCut ? Color.green.opacity(0.5) : .green)
                    Rectangle()
                        .fill(color)
                        .frame(width: cellWidth, height: cellHeight)
                        .position(x: cellWidth * CGFloat(col) + cellWidth/2,
                                  y: cellHeight * CGFloat(row) + cellHeight/2)
                }
            }
        }
        .ignoresSafeArea()
    }
}

#Preview {
    MazeView()
}
