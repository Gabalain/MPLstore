//
//  CreateModel.swift
//  MPLstore
//
//  Created by Alain Gabellier on 08/10/2018.
//  Copyright © 2018 Alain Gabellier. All rights reserved.
//

import Foundation
import RealmSwift

func resetModel() {
    
    // Reset All
    deletePersons()
    deleteCards()
    deleteCategories()
    deleteServices()
    
    
    Person().createPerson(name: "Thomas", image: "Thomas", rating: 43, reviews: 23, password: "", mail: "thomas.roberts@gmail.com", phone: "06 12 34 56 78", street: "5 rue Foch", zip: 34000, city: "Montpellier")
    Person().createPerson(name: "Marion", image: "Marion", rating: 35, reviews: 17, password: "", mail: "marion.miles@gmail.com", phone: "06 12 34 56 78", street: "15 rue Sainte-Anne", zip: 34000, city: "Montpellier")
    Person().createPerson(name: "Mike", image: "Mike", rating: 39, reviews: 3, password: "", mail: "mike.wilson@gmail.com", phone: "06 12 34 56 78", street: "2 rue de la Loge", zip: 34000, city: "Montpellier")
    Person().createPerson(name: "Emma", image: "Emma", rating: 29, reviews: 12, password: "", mail: "emma.denis@gmail.com", phone: "06 12 34 56 78", street: "12 rue de l'école de Pharmacie", zip: 34000, city: "Montpellier")
    
    let persons = getPersons()
    for person in persons {
        Card().createCard(name: "MPLstore", balance: 0.0, active: false, person: person)
        Card().createCard(name: "MPLfood", balance: 0.0, active: false, person: person)
        Card().createCard(name: "MPLshop", balance: 0.0, active: false, person: person)
        Card().createCard(name: "New card", balance: 0.0, active: true, person: person)
    }
    
    Category().createCategory(name: "Ads & Offers", text: "Ads and offers from people around you", icon: "ads", color: "d9823b")
    Category().createCategory(name: "Collective Drive", text: " ", icon: "drive", color: "5097d5")
    Category().createCategory(name: "Associations", text: "Help your favorite associations", icon: "associations", color: "e0787d")
    Category().createCategory(name: "Manage your Ads", text: "Create, update or remove your ads", icon: "manage", color: "57b99d")
    
    var category = getCategories()[0]
    var person = getPersonWithId(0)
    Service().createService(name: "Pets care",
                            text: "I'm living in a house with fenced garden in the center of Montpellier and would be happy to take care of your pets when needed",
                            image: "cat",
                            person: person,
                            category: category)
    person = getPersonWithId(1)
    Service().createService(name: "Child care",
                            text: "I'll take care of your child after school.",
                            image: "child",
                            person: person,
                            category: category)
    person = getPersonWithId(2)
    Service().createService(name: "Home cooking",
                            text: "Chef in a famous restaurant, I propose to cook directly at your home for special event ... or not.",
                            image: "cook",
                            person: person,
                            category: category)
    
    category = getCategories()[2]
    Service().createService(name: "Local farmers",
                            text: "Promoting local & healthy product.\nTake care of you ... and the planet",
                            image: "farmers",
                            person: nil,
                            category: category)
    Service().createService(name: "Clothes 2nd life",
                            text: "Collecting clothes for homeless persons.",
                            image: "clothes",
                            person: nil,
                            category: category)
    
    
}
