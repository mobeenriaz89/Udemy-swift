//
//  ContentView.swift
//  Contact Card
//
//  Created by Mubeen Riaz on 17/07/2023.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        ZStack {
            Color(red: 0.16, green: 0.50, blue: 0.73)
                .ignoresSafeArea()
            VStack {
                Image("profile")
                    .resizable()
                    .aspectRatio(contentMode: .fill)
                    .frame(width: 150, height: 150)
                    .clipShape(Circle())
                    .overlay(Circle().stroke(Color.white, lineWidth: 5))
                Text("Mubeen Riaz")
                    .font(Font.custom("Lumanosimo-Regular", size: 40))
                    .bold()
                    .foregroundColor(.white)
                Text("Mobile Apps Developer")
                    .font(.system(size: 25))
                    .foregroundColor(.white)
                Divider()
                InfoView(phoneNumber: "03135678420", imageName: "phone.fill")
                InfoView(phoneNumber: "mobeenriaz89@gmail.com", imageName: "envelope.fill")
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
