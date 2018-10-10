//
//  RealmManagement.swift
//  GaB
//
//  Created by Alain Gabellier on 27/09/2018.
//  Copyright © 2018 Alain Gabellier. All rights reserved.
//

import Foundation
import RealmSwift

// Init REALM
let realm = try! Realm()
let defaults = UserDefaults.standard

//MARK: CREATE
func saveCard(_ card: Card) {
    do { try realm.write {
        realm.add(card)
        }
    } catch {
        print("Error saving card \(error)")
    }
}

func setPersonOfCard(person: Person, card: Card) {
    do {
        try realm.write {
            person.cards.append(card)
        }
    } catch {
        print("Error setting person of card ------------------------")
        debugPrint(error)
    }
}

func saveCategory(_ category: Category) {
    do { try realm.write {
        realm.add(category)
        }
    } catch {
        print("Error saving card \(error)")
    }
}

func saveService(_ service: Service) {
    do { try realm.write {
        realm.add(service)
        }
    } catch {
        print("Error saving Service \(error)")
    }
}

func setPersonOfService(person: Person, service: Service) {
    do {
        try realm.write {
            person.services.append(service)
        }
    } catch {
        print("Error setting person of Service ------------------------")
        debugPrint(error)
    }
}

func setCategoryOfService(category: Category, service: Service) {
    do {
        try realm.write {
            category.services.append(service)
        }
    } catch {
        print("Error setting category of Service ------------------------")
        debugPrint(error)
    }
}

func savePerson(_ person: Person) {
    do { try realm.write {
        realm.add(person)
        }
    } catch {
        print("Error saving Person \(error)")
    }
}


//MARK: READ
func getCards() -> Results<Card> {
    return realm.objects(Card.self)
}

func getSortedCardsOfPerson() -> Results<Card> {
    let id = defaults.integer(forKey: "userId")
    // Find Person with this id
    let person = getPersonWithId(id)
    print("Person: ", person)
    // Query using an NSPredicate
    let predicate = NSPredicate(format: "ANY person = %@", person)
    print(predicate)
    return realm.objects(Card.self).filter(predicate).sorted(byKeyPath: "active", ascending: false)
}

func getCategories() -> Results<Category> {
    return realm.objects(Category.self)
}

func getPersons() -> Results<Person> {
    return realm.objects(Person.self)
}

func getPersonWithId(_ id: Int) -> Person {
    let predicate = NSPredicate(format: "id = %d", id)
    print(id, predicate)
    return realm.objects(Person.self).filter(predicate).first ?? realm.objects(Person.self).first!
}

func getServicesOfCategory(_ category: Category) -> Results<Service> {
    // Query using an NSPredicate
    let predicate = NSPredicate(format: "ANY category = %@", category)
    return realm.objects(Service.self).filter(predicate)
}

//MARK: UPDATE
func updateCardBalance(_ card: Card, _ amount: Float) {
    try! realm.write {
        card.balance = card.balance + amount
    }
}
func activateCard(_ card: Card) {
    try! realm.write {
        card.active = true
        card.balance = 0.0
    }
}
func resetCard(_ card: Card) {
    if card.active && card.name != "New card" {
        try! realm.write {
            card.active = false
            card.balance = 0.0
        }
    }
}

//MARK: DELETE
func deleteCards() {
    let cards = realm.objects(Card.self)
    do {
        try realm.write {
            realm.delete(cards)
        }
    } catch {
        print("Error deleting cards, \(error)")
    }
}

func deleteCard(at index: Int) {
    let cardForDeletion = realm.objects(Card.self)[index]
    do {
        try realm.write {
            realm.delete(cardForDeletion)
        }
    } catch {
        print("Error deleting card at index \(index), \(error)")
    }
}

func deleteCategories() {
    let categories = realm.objects(Category.self)
    do {
        try realm.write {
            realm.delete(categories)
        }
    } catch {
        print("Error deleting categories, \(error)")
    }
}

func deleteServices() {
    let services = realm.objects(Service.self)
    do {
        try realm.write {
            realm.delete(services)
        }
    } catch {
        print("Error deleting services, \(error)")
    }
}

func deletePersons() {
    let persons = realm.objects(Person.self)
    do {
        try realm.write {
            realm.delete(persons)
        }
    } catch {
        print("Error deleting persons, \(error)")
    }
}

//
//func setAccountOfTransaction(account: Account, transaction: Transaction) {
//    do {
//        try realm.write {
//            account.transactions.append(transaction)
//        }
//    } catch {
//        print("Error setting account of Transaction ------------------------")
//        debugPrint(error)
//    }
//}
//
//func setCategoryOfTransaction(category: Category, transaction: Transaction) {
//    do {
//        try realm.write {
//            category.transactions.append(transaction)
//        }
//    } catch {
//        print("Error setting category of Transaction ------------------------")
//        debugPrint(error)
//    }
//}
//
//
//
////MARK: READ
//func getTransactions() -> Results<Transaction> {
//    return realm.objects(Transaction.self)
//}
//
//func getTransactionsInAccount(_ accountName: String)  -> Results<Transaction> {
//    // Find Account with this name
//    let predicate1 = NSPredicate(format: "name == %@", accountName)
//    let account = realm.objects(Account.self).filter(predicate1).first ?? realm.objects(Account.self).first!
//    // Query using an NSPredicate
//    let predicate2 = NSPredicate(format: "ANY account = %@", account)
//    return realm.objects(Transaction.self).filter(predicate2)
//}
//
//func getTransactionsInAccountWithMonthAndYear(accountName: String, month: Int, year: Int)  -> Results<Transaction> {
//    // Create StartDateOfMonth
//    var components = DateComponents()
//    components.day = 1
//    components.month = month
//    components.year = year
//    var startDate = Calendar.current.date(from: components)
//    components.day = 0
//    components.month = 0
//    components.year = 0
//    components.hour = 14
//    startDate = Calendar.current.date(byAdding: components, to: startDate!)
//    print(month, year, startDate!)
//    
//    //Now create endDateOfMonth using startDateOfMonth
//    components.year = 0
//    components.month = 1
//    components.day = -1
//    components.hour = 0
//    let endDate = Calendar.current.date(byAdding: components, to: startDate!)
//    
//    // Find Account with name accountName
//    let predicate1 = NSPredicate(format: "name == %@", accountName)
//    let account = realm.objects(Account.self).filter(predicate1).first ?? realm.objects(Account.self).first!
//    
//    let predicate = NSPredicate(format: "ANY account == %@ AND date >= %@ AND date <= %@", account, startDate! as CVarArg, endDate! as CVarArg)
//    return realm.objects(Transaction.self).filter(predicate)
//}
//
//func getCategoryOfTransaction(transaction: Transaction) -> Category {
//    let predicate = NSPredicate(format: "ANY transactions == %@", transaction)
//    return realm.objects(Category.self).filter(predicate).first!
//}
//
////MARK: UPDATE
//func changeReccurence(of transaction: Transaction) {
//    try! realm.write {
//        transaction.reccurent = !transaction.reccurent
//    }
//}
//
////MARK: DELETE
//func deleteTransactions() {
//    let transactions = realm.objects(Transaction.self)
//    do {
//        try realm.write {
//            realm.delete(transactions)
//        }
//    } catch {
//        print("Error deleting transaction, \(error)")
//    }
//}
