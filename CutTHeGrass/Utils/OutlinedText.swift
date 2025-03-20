//
//  OutlinedText.swift
//  CutTHeGrass
//
//  Created by Herlandro Hermogenes on 20/03/2025.
//

import SwiftUI

struct OutlinedText: UIViewRepresentable {
    var text: String
    var font: UIFont
    var textColor: UIColor = .white
    var strokeColor: UIColor = .black
    // Negative value fill the text and apply the stroke
    var strokeWidth: CGFloat = -2.0

    func makeUIView(context: Context) -> UILabel {
        let label = UILabel()
        label.numberOfLines = 0
        label.textAlignment = .center
        label.backgroundColor = .clear
        return label
    }
    
    func updateUIView(_ uiView: UILabel, context: Context) {
        let attributes: [NSAttributedString.Key: Any] = [
            .font: font,
            .foregroundColor: textColor,
            .strokeColor: strokeColor,
            .strokeWidth: strokeWidth
        ]
        uiView.attributedText = NSAttributedString(string: text, attributes: attributes)
    }
}
