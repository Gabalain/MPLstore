//
//  Person.swift
//  MPLstore
//
//  Created by Alain Gabellier on 07/10/2018.
//  Copyright © 2018 Alain Gabellier. All rights reserved.
//

import Foundation
import RealmSwift

class Person: Object {
    @objc dynamic var id: Int = 0
    @objc dynamic var name: String = ""
    @objc dynamic var image: String = ""
    @objc dynamic var password: String = ""
    @objc dynamic var rating: Int = 0
    @objc dynamic var reviews: Int = 0
    @objc dynamic var mail: String = ""
    @objc dynamic var phone: String = ""
    @objc dynamic var street: String = ""
    @objc dynamic var zip: Int = 0
    @objc dynamic var city: String = ""
    let services = List<Service>()
    let cards = List<Card>()
    
    func createPerson(name: String, image: String, rating: Int, reviews: Int, password: String, mail: String, phone: String, street: String, zip: Int, city: String) {
        var id = 0
        let realm = try! Realm()
        let persons = realm.objects(Person.self)
        for person in persons {
            if person.id >= id { id = person.id + 1 }
        }
        self.id = id
        self.name = name
        self.image = image
        self.password = password
        self.rating = rating
        self.reviews = reviews
        self.mail = mail
        self.phone = phone
        self.street = street
        self.zip = zip
        self.city = city
        savePerson(self)
    }
}
