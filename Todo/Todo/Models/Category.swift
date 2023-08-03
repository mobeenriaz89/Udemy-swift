//
//  Category.swift
//  Todo
//
//  Created by Mubeen Riaz on 27/07/2023.
//

import Foundation
import RealmSwift

class Category: Object {
    @objc dynamic var name: String = ""
    @objc dynamic var color: String = ""
    let items = List<Item>()
}
