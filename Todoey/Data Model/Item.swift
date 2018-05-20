//
//  Item.swift
//  Todoey
//
//  Created by Gregory Kolosov on 20/05/2018.
//  Copyright © 2018 Gregory Kolosov. All rights reserved.
//

import Foundation
import RealmSwift

class Item : Object {
    @objc dynamic var title : String = ""
    @objc dynamic var done : Bool = false
    var parentCategory = LinkingObjects(fromType: Category.self, property: "items")
}
