//
//  InfoView.swift
//  Contact Card
//
//  Created by Mubeen Riaz on 17/07/2023.
//

import SwiftUI

struct InfoView: View {
    
    let phoneNumber: String
    let imageName: String
    
    var body: some View {
        RoundedRectangle(cornerRadius:25)
            .fill(.white)
            .frame(height: 50)
            .overlay(HStack {
                Image(systemName: imageName).foregroundColor(.green)
                Text(phoneNumber).foregroundColor(Color("Info Color"))
            })
            .padding(.all)
    }
}

struct InfoView_Previews: PreviewProvider {
    static var previews: some View {
        InfoView(phoneNumber: "1122", imageName: "phone.fill")
            .previewLayout(.sizeThatFits)
        
    }
}
