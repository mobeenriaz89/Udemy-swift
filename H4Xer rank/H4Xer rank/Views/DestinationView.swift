//
//  DestinationView.swift
//  H4Xer rank
//
//  Created by Mubeen Riaz on 19/07/2023.
//

import SwiftUI

struct DestinationView: View {
    let url: String?
    var body: some View {
        WebView(urlString: url!)
    }
}

struct DestinationView_Previews: PreviewProvider {
    static var previews: some View {
        DestinationView(url: "http")
    }
}

