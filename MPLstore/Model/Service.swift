//
//  File.swift
//  MPLstore
//
//  Created by Alain Gabellier on 07/10/2018.
//  Copyright © 2018 Alain Gabellier. All rights reserved.
//

import Foundation
import RealmSwift

class Service: Object {
    @objc dynamic var id: Int = 0
    @objc dynamic var name: String = ""
    @objc dynamic var text: String = ""
    @objc dynamic var image: String = ""
    var person = LinkingObjects(fromType: Person.self, property: "services")
    var category = LinkingObjects(fromType: Category.self, property: "services")
    
    func createService(name: String, text: String, image: String, person: Person?, category: Category) {
        var id = 0
        let realm = try! Realm()
        let services = realm.objects(Service.self)
        for service in services {
            if service.id >= id { id = service.id + 1 }
        }
        self.id = id
        self.name = name
        self.text = text
        self.image = image
        saveService(self)
        
        if let person = person {
            setPersonOfService(person: person, service: self)
        }
        setCategoryOfService(category: category, service: self)
    }
}
