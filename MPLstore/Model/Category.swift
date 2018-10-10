//
//  category.swift
//  MPLstore
//
//  Created by Alain Gabellier on 05/10/2018.
//  Copyright © 2018 Alain Gabellier. All rights reserved.
//

import Foundation
import RealmSwift

class Category: Object {
    @objc dynamic var name: String = ""
    @objc dynamic var text: String = ""
    @objc dynamic var icon: String = ""
    @objc dynamic var color: String = ""
    let services = List<Service>()
    
    func createCategory(name: String, text: String, icon: String ,color: String) {
        self.name = name
        self.text = text
        self.icon = icon
        self.color = color
        saveCategory(self)
    }
}
