//
//  Category.swift
//  Todoey
//
//  Created by Gregory Kolosov on 20/05/2018.
//  Copyright © 2018 Gregory Kolosov. All rights reserved.
//

import Foundation
import RealmSwift

class Category : Object {
    @objc dynamic var name : String = ""
    @objc dynamic var colourC : String = ""
    let items = List<Item>()
    
}
