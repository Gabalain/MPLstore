//
//  ViewController.swift
//  MPLstore
//
//  Created by Alain Gabellier on 04/10/2018.
//  Copyright © 2018 Alain Gabellier. All rights reserved.
//

import UIKit

class ListCards: UIViewController, UITableViewDelegate, UITableViewDataSource, canReceiveUpdatedCard {
    func updatedCardReceived(card: Card) {
        print("Received card : ", card.balance)
        
        listCardsTV.reloadData()
    }
    
    
    @IBOutlet weak var listCardsTV: UITableView!
    @IBOutlet weak var balanceLbl: UILabel!
    
    var cards: [Card] = []
    var totalBalance: Float = 0.0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let cardStore = Card()
        cardStore.active = true
        cardStore.balance = 12.5
        cardStore.name = "MPLStore"
        
        let cardNew = Card()
        cardNew.active = true
        cardNew.balance = 0.0
        cardNew.name = "New card"
        
        let cardFood = Card()
        cardFood.active = false
        cardFood.balance = 0.0
        cardFood.name = "MPLFood"
        
        let cardShop = Card()
        cardShop.active = false
        cardShop.balance = 0.0
        cardShop.name = "MPLShop"
        
        cards = [cardStore, cardNew, cardFood, cardShop]
        
        listCardsTV.delegate = self
        listCardsTV.dataSource = self
        
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        // Sort cards = Active, New, Not Active and calculate totalBalance
        var activeCards: [Card] = []
        var newCards: [Card] = []
        var nonActiveCards: [Card] = []
        for card in cards {
            if card.active && card.name != "New card" { activeCards.append(card) }
            if card.name == "New card" { newCards.append(card) }
            if !card.active { nonActiveCards.append(card) }
        }
        
        let cards2 = [activeCards, newCards, nonActiveCards]
        cards = cards2.flatMap { $0 }
        
        for card in cards {
            print(card.name, card.active)
        }
        
        totalBalance = 0.0
        for card in cards {
            totalBalance += card.balance
        }
        self.balanceLbl.text = floatToString(totalBalance, 2)
        
        return cards.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = listCardsTV.dequeueReusableCell(withIdentifier: "cardCell", for: indexPath) as! CardCell
        
        let imageName = cards[indexPath.row].name + "_card"
        cell.cardIV.image = UIImage(named: imageName)
        cell.nameLbl.text = cards[indexPath.row].name
        
        if cards[indexPath.row].active {
            cell.cardIV.alpha = 1
            cell.balanceLbl.text = floatToString(cards[indexPath.row].balance, 2) + " MPLcoins"
        } else {
            cell.cardIV.alpha = 0.5
            cell.balanceLbl.text = ""
        }
        
        if cards[indexPath.row].name == "New card" {
            cell.balanceLbl.text = ""
            cell.nameLbl.text = "Scan card"
            cell.cardIV.image = UIImage(named: "Scan")
        }
        tableView.rowHeight = 100
        return cell
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        listCardsTV.reloadData()
        
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if cards[indexPath.row].active {
            performSegue(withIdentifier: "showCard", sender: self)
        } else if cards[indexPath.row].name == "New card" {
            performSegue(withIdentifier: "scanCard", sender: self)
        } else {
            performSegue(withIdentifier: "newCard", sender: self)
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        if segue.identifier == "showCard" {
            guard let showCard = segue.destination as? ShowCard else {
                print("Destination not found")
                return
            }
            
            guard let brandIndex = listCardsTV.indexPathForSelectedRow else {
                print("Category Index not found")
                return
            }
            
            showCard.card = cards[brandIndex.row]
            showCard.delegate = self
        }
        
        if segue.identifier == "newCard" {
            guard let newCard = segue.destination as? NewCard else {
                print("Destination not found")
                return
            }
            
            guard let brandIndex = listCardsTV.indexPathForSelectedRow else {
                print("Category Index not found")
                return
            }
            
            newCard.card = cards[brandIndex.row]
            newCard.delegate = self
        }
    }
     


}

