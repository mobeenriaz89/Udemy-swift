//
//  Item.swift
//  Todo
//
//  Created by Mubeen Riaz on 27/07/2023.
//

import Foundation
import RealmSwift

class Item: Object{
    @objc dynamic var name: String = ""
    @objc dynamic var isChecked: Bool = false
    @objc dynamic var dateCreated: Date?
    var parentCategory = LinkingObjects(fromType: Category.self, property: "items")
}
