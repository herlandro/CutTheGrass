//
//  LoginView.swift
//  CutTHeGrass
//
//  Created by Herlandro Hermogenes on 20/03/2025.
//

import SwiftUI

struct LoginView: View {
    
    // Use @AppStorage to persist the name
    @AppStorage("profileName") var savedName: String = ""
    
    @State private var name: String = ""
    @State private var showImagePicker: Bool = false
    @State private var image: Image? = nil
    @State private var inputImage: UIImage? = nil
    @State private var isLoggedIn: Bool = false
    
    var body: some View {
        NavigationView {
            VStack(spacing: 20) {
                // Display chosen image or a default icon
                if let image = image {
                    image
                        .resizable()
                        .scaledToFill()
                        .frame(width: 150, height: 150)
                        .clipShape(Circle())
                } else {
                    Image(systemName: "person.crop.circle.fill")
                        .resizable()
                        .scaledToFill()
                        .frame(width: 150, height: 150)
                        .foregroundColor(.gray)
                }
                
                Button("Selecionar Foto") {
                    showImagePicker = true
                }
                
                TextField("Digite seu nome", text: $name)
                    .padding()
                    .background(Color(UIColor.systemGray6))
                    .cornerRadius(8)
                
                Button("Entrar") {
                    // Persist the name and image
                    savedName = name
                    if let inputImage = inputImage {
                        if let data = inputImage.jpegData(compressionQuality: 1.0) {
                            UserDefaults.standard.set(data, forKey: "profileImage")
                        }
                    }
                    isLoggedIn = true
                }
                .disabled(name.isEmpty)
                .padding()
                .frame(maxWidth: .infinity)
                .background(name.isEmpty ? Color.gray : Color.blue)
                .foregroundColor(.white)
                .cornerRadius(8)
                
                NavigationLink(destination: CutTHeGrassGameView(), isActive: $isLoggedIn) {
                    EmptyView()
                }
            }
            .padding()
            .sheet(isPresented: $showImagePicker, onDismiss: loadImage) {
                ImagePicker(image: $inputImage)
            }
            .onAppear {
                // Load saved name if available
                if !savedName.isEmpty {
                    name = savedName
                }
                // Load saved image if available
                if let imageData = UserDefaults.standard.data(forKey: "profileImage"),
                   let uiImage = UIImage(data: imageData) {
                    image = Image(uiImage: uiImage)
                }
            }
        }
    }
    
    // Updates the view with the chosen image
    func loadImage() {
        guard let inputImage = inputImage else { return }
        image = Image(uiImage: inputImage)
    }
}

#Preview {
    LoginView()
}
