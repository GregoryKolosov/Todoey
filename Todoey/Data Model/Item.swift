//
//  Item.swift
//  Todoey
//
//  Created by Gregory Kolosov on 30/03/2018.
//  Copyright © 2018 Gregory Kolosov. All rights reserved.
//

import Foundation

class Item: Encodable, Decodable {
    var title: String = ""
    var done: Bool = false
}
