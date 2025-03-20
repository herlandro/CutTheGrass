//
//  ProfileView.swift
//  CutTHeGrass
//
//  Created by Herlandro Hermogenes on 20/03/2025.
//

import SwiftUI

struct ProfileView: View {
    
    // Persist the user's name
    @AppStorage("profileName") var savedName: String = ""
    
    @State private var image: Image? = nil
    @State private var inputImage: UIImage? = nil
    
    var body: some View {
        VStack(spacing: 20) {
            // Display the user's profile image or a default icon
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
            
            // Display the user's name
            if !savedName.isEmpty {
                Text(savedName)
                    .font(.title)
                    .bold()
            } else {
                Text("No name")
                    .font(.title)
                    .bold()
            }
            
            // Logout button to clear the profile data
            Button("Logout") {
                savedName = ""
                image = nil
                inputImage = nil
                UserDefaults.standard.removeObject(forKey: "profileImage")
            }
            .padding()
            .frame(maxWidth: .infinity)
            .background(Color.red)
            .foregroundColor(.white)
            .cornerRadius(8)
        }
        .padding()
        .onAppear {
            // Load saved image if available
            if let imageData = UserDefaults.standard.data(forKey: "profileImage"),
               let uiImage = UIImage(data: imageData) {
                image = Image(uiImage: uiImage)
            }
        }
    }
}

#Preview {
    ProfileView()
}
