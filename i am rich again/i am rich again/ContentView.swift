//
//  ContentView.swift
//  i am rich again
//
//  Created by Mobeen Riaz on 16/07/2023.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
            ZStack {
                Color(.systemTeal)
                    .edgesIgnoringSafeArea(.all)
                VStack {
                    Text("I Am Rich").font(.system(size: 40)).foregroundColor(Color.white)
                    Image("diamond").resizable()
                        .aspectRatio(contentMode: .fit)
                        .frame(width: 200.0, height: 200.0,alignment: .center)
                }
            }
        }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
