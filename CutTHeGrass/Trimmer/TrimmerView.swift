//
//  Trimmer.swift
//  CutTHeGrass
//
//  Created by Herlandro Hermogenes on 20/03/2025.
//

import SwiftUI

struct TrimmerView: View {
    @ObservedObject var viewModel: TrimmerViewModel
    
    var body: some View {
        // Utiliza o viewModel.image e viewModel.position para renderizar a imagem do trimmer
        viewModel.image
            .resizable()
            .frame(width: 50, height: 50)
            .position(viewModel.position)
            .gesture(
                DragGesture()
                    .onChanged { value in
                        viewModel.updatePosition(to: value.location)
                    }
            )
    }
}
