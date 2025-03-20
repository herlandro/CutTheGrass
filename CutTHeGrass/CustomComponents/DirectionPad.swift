//
//  DirectionPad.swift
//  CutTHeGrass
//
//  Created by Herlandro Hermogenes on 20/03/2025.
//

import SwiftUI

struct DirectionPad: View {
    var action: (String) -> Void
    @State private var knobOffset: CGSize = .zero
    let maxOffset: CGFloat = 30  // valor máximo de deslocamento

    var body: some View {
        ZStack {
            // Base do joystick (fixa)
            Circle()
                .fill(Color.gray.opacity(0.3))
                .frame(width: 150, height: 150)
            
            // Knob (botão) que pode ser arrastado
            Circle()
                .fill(Color.blue.opacity(0.7))
                .frame(width: 70, height: 70)
                .offset(knobOffset)
                .gesture(
                    DragGesture(minimumDistance: 0)
                        .onChanged { value in
                            // Calcula o novo offset usando 25% da tradução
                            let rawOffset = CGSize(width: value.translation.width * 0.25,
                                                   height: value.translation.height * 0.25)
                            // Limita o offset ao máximo definido
                            let clampedOffset = CGSize(
                                width: min(max(rawOffset.width, -maxOffset), maxOffset),
                                height: min(max(rawOffset.height, -maxOffset), maxOffset)
                            )
                            // Atualiza o offset com animação suave
                            withAnimation(.easeOut(duration: 0.1)) {
                                knobOffset = clampedOffset
                            }
                            
                            // Calcula a direção baseada no gesto original (não clamped) para maior precisão
                            let dx = value.translation.width
                            let dy = value.translation.height
                            let absDx = abs(dx)
                            let absDy = abs(dy)
                            var direction = ""
                            
                            // Se o movimento for muito pequeno, ignora
                            if absDx < 10 && absDy < 10 { return }
                            
                            // Detecta movimento diagonal se a diferença for pequena
                            if abs(absDx - absDy) < 10 {
                                if dx > 0 && dy < 0 {
                                    direction = "upRight"
                                } else if dx < 0 && dy < 0 {
                                    direction = "upLeft"
                                } else if dx > 0 && dy > 0 {
                                    direction = "downRight"
                                } else if dx < 0 && dy > 0 {
                                    direction = "downLeft"
                                }
                            } else if absDx > absDy {
                                // Movimento horizontal
                                direction = dx > 0 ? "right" : "left"
                            } else {
                                // Movimento vertical
                                direction = dy > 0 ? "down" : "up"
                            }
                            
                            if !direction.isEmpty {
                                action(direction)
                            }
                        }
                        .onEnded { _ in
                            // Ao soltar, retorna o knob à posição central com animação spring
                            withAnimation(.spring()) {
                                knobOffset = .zero
                            }
                        }
                )
        }
        .frame(width: 150, height: 150)
    }
}

struct DirectionPad_Previews: PreviewProvider {
    static var previews: some View {
        DirectionPad { direction in
            print("Direction: \(direction)")
        }
        .previewLayout(.sizeThatFits)
        .padding()
    }
}
