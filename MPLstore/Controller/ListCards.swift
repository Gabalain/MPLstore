//
//  ViewController.swift
//  MPLstore
//
//  Created by Alain Gabellier on 04/10/2018.
//  Copyright © 2018 Alain Gabellier. All rights reserved.
//

import UIKit

class ListCards: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    @IBOutlet weak var listCardsTV: UITableView!
    @IBOutlet weak var balanceLbl: UILabel!
    
    var cards: [Card] = []
    var totalBalance: Float = 0.0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        var cardStore = Card()
        cardStore.active = true
        cardStore.balance = 12.3
        cardStore.name = "MPLStore"
        
        var cardNew = Card()
        cardNew.active = true
        cardNew.balance = 0.0
        cardNew.name = "New card"
        
        var cardFood = Card()
        cardFood.active = false
        cardFood.balance = 0.0
        cardFood.name = "MPLFood"
        
        var cardShop = Card()
        cardShop.active = false
        cardShop.balance = 0.0
        cardShop.name = "MPLShop"
        
        cards = [cardStore, cardNew, cardFood, cardShop]
        
        listCardsTV.delegate = self
        listCardsTV.dataSource = self
        
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        for card in cards {
            totalBalance += card.balance
        }
        self.balanceLbl.text = floatToString(totalBalance, 2)
        
        return cards.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = listCardsTV.dequeueReusableCell(withIdentifier: "cardCell", for: indexPath) as! CardCell
        
        let imageName = cards[indexPath.row].name + "_card"
        print(imageName)
        cell.cardIV.image = UIImage(named: imageName)
        cell.nameLbl.text = cards[indexPath.row].name
        cell.balanceLbl.text = floatToString(cards[indexPath.row].balance, 2) + " MPLcoins"
        
        if !cards[indexPath.row].active {
            cell.cardIV.alpha = 0.5
            cell.balanceLbl.text = ""
        }
        
        if cards[indexPath.row].name == "New card" {
            cell.balanceLbl.text = ""
            cell.cardIV.image = UIImage(named: "Scan")
        }
        

        
        tableView.rowHeight = 100
        return cell
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(true)
        
        totalBalance = 0.0
        listCardsTV.reloadData()
        
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        performSegue(withIdentifier: "showCard", sender: self)
        
//        let modalViewController = ShowCard()
//        modalViewController.modalPresentationStyle = .overCurrentContext
//        present(modalViewController, animated: true, completion: nil)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard let showCard = segue.destination as? ShowCard else {
            print("Destination not found")
            return
        }
        
        guard let brandIndex = listCardsTV.indexPathForSelectedRow else {
            print("Category Index not found")
            return
        }
        
        showCard.brandName = cards[brandIndex.row].name
        showCard.balance = cards[brandIndex.row].balance
    }
     


}

