//
//  Card.swift
//  MPLstore
//
//  Created by Alain Gabellier on 04/10/2018.
//  Copyright © 2018 Alain Gabellier. All rights reserved.
//

import Foundation
import RealmSwift

class Card: Object {
    @objc dynamic var name: String = ""
    @objc dynamic var balance: Float = 0.0
    @objc dynamic var active: Bool = false
    var person = LinkingObjects(fromType: Person.self, property: "cards")
    
    func createCard(name: String, balance: Float ,active: Bool, person: Person) {
        self.name = name
        self.balance = balance
        self.active = active
        saveCard(self)
        
        setPersonOfCard(person: person, card: self)
    }
}
