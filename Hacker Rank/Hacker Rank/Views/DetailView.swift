//
//  DetailView.swift
//  Hacker Rank
//
//  Created by Mobeen Riaz on 19/07/2023.
//

import SwiftUI
import WebKit

struct DetailView: View {
    
    let webUrl: String?
    
    var body: some View {
        WebView(urlString: webUrl)
    }
}

struct DetailView_Previews: PreviewProvider {
    static var previews: some View {
        DetailView(webUrl: "http")
    }
}




