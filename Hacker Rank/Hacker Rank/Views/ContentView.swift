//
//  ContentView.swift
//  Hacker Rank
//
//  Created by Mobeen Riaz on 19/07/2023.
//

import SwiftUI

struct ContentView: View {
    
    @ObservedObject var networkManager = NetworkManager()
    
    var body: some View {
        NavigationView {
            List(networkManager.posts) { post in
                    NavigationLink(destination: DetailView(webUrl: post.url)) { Text(post.title) }
                }
            
            .navigationTitle("Hacker Rank")
        }
        .onAppear{
            self.networkManager.fetchData()
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
