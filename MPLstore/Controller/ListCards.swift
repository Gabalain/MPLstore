//
//  ViewController.swift
//  MPLstore
//
//  Created by Alain Gabellier on 04/10/2018.
//  Copyright © 2018 Alain Gabellier. All rights reserved.
//

import UIKit
import RealmSwift

class ListCards: UIViewController, UITableViewDelegate, UITableViewDataSource, canReceiveUpdatedCard {
    
    func updatedCardReceived(card: Card) {
        print("Received card : ", card.balance)
        
        listCardsTV.reloadData()
    }
    
    @IBOutlet weak var listCardsTV: UITableView!
    @IBOutlet weak var balanceLbl: UILabel!
    @IBOutlet weak var personLbl: UILabel!
    @IBOutlet weak var imageIV: UIImageView!
    
    var cards: Results<Card>!
    var totalBalance: Float = 0.0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Rounded image
        imageIV.layer.cornerRadius = imageIV.frame.width / 2
        imageIV.layer.masksToBounds = true
        
        // Customized Tabbar transparent green with no border
        CustomTabBar.appearance().layer.borderWidth = 0.0
        CustomTabBar.appearance().clipsToBounds = true
//        CustomTabBar.appearance().backgroundColor = UIColor.init(white: 0, alpha: 0)
        CustomTabBar.appearance().backgroundColor = UIColor.red
        CustomTabBar.appearance().tintColor = hexStringToUIColor(hex: "55B397")
        
//        resetModel()
        updateView()
        
        listCardsTV.delegate = self
        listCardsTV.dataSource = self
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        updateView()
    }
    
    func updateView() {
        let defaults = UserDefaults.standard
        
        // defaults.removePersistentDomain(forName: Bundle.main.bundleIdentifier!)
        var userId: Int? = defaults.integer(forKey: "userId")
        if userId == nil {
            userId = getPersons().first?.id
            defaults.set(userId, forKey: "userId")
        }
        let user = getPersonWithId(userId!)
        personLbl.text = user.name
        imageIV.image = UIImage(named: user.image)
        
        cards = getSortedCardsOfPerson()
        listCardsTV.reloadData()
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
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
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        if cards[indexPath.row].active && cards[indexPath.row].name != "New card" {
            performSegue(withIdentifier: "showCard", sender: self)
        } else if cards[indexPath.row].name == "New card" {
            performSegue(withIdentifier: "goToScanCard", sender: self)
        } else {
            performSegue(withIdentifier: "newCard", sender: self)
        }
        
        listCardsTV.deselectRow(at: indexPath, animated: true)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard let brandIndex = listCardsTV.indexPathForSelectedRow else { return }
        
        if segue.identifier == "showCard" {
            guard let showCard = segue.destination as? ShowCard else { return }
            showCard.card = cards[brandIndex.row]
            showCard.delegate = self
        }
        
        if segue.identifier == "newCard" {
            guard let newCard = segue.destination as? NewCard else { return }
            newCard.card = cards[brandIndex.row]
            newCard.delegate = self
        }
    }
    
    //MARK: - Manage Swipeable Cells
    func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        
        let reset = cardReset(at: indexPath)
        return UISwipeActionsConfiguration(actions: [reset])
    }
    
    // Set to reccurent
    func cardReset(at indexPath: IndexPath) -> UIContextualAction {
        let card = cards![indexPath.row]
        
        let action = UIContextualAction(style: .normal, title: "Reset") { (action, view, completion) in
            resetCard(card)
            DispatchQueue.main.async {
                self.listCardsTV.reloadData()
            }
            completion(true)
        }
        action.backgroundColor = UIColor.lightGray
        return action
    }
}


