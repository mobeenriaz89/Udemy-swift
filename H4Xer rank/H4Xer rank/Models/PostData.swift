//
//  PostData.swift
//  H4Xer rank
//
//  Created by Mubeen Riaz on 19/07/2023.
//

import Foundation

struct Results: Decodable{
    var hits: [Post]
}

struct Post: Decodable, Identifiable {
    var id: String {
        return objectID
    }
    var objectID: String
    var points: Int
    var title: String
    var url: String?
}
