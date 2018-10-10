//
//  listCategories.swift
//  MPLstore
//
//  Created by Alain Gabellier on 05/10/2018.
//  Copyright © 2018 Alain Gabellier. All rights reserved.
//

import UIKit
import RealmSwift

class ListCategories: UIViewController, UITableViewDelegate, UITableViewDataSource {

    @IBOutlet weak var listCategoriesTV: UITableView!
    
    var categories: Results<Category>!

    override func viewDidLoad() {
        super.viewDidLoad()
        
        categories = getCategories()
        
        listCategoriesTV.delegate = self
        listCategoriesTV.dataSource = self
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return categories.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = listCategoriesTV.dequeueReusableCell(withIdentifier: "listCategoryCell", for: indexPath) as! CategoryCell
        
        let category = categories[indexPath.row]
        cell.nameLbl.text = category.name
        cell.nameLbl.textColor = hexStringToUIColor(hex: category.color)
        cell.iconIV.image = UIImage(named: category.icon)
        cell.textLbl.text = category.text
        
        tableView.rowHeight = 160
        return cell
    }
    
    // Segue
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if categories[indexPath.row].name == "Collective Drive" {
            performSegue(withIdentifier: "goToDrive", sender: self)
        } else {
            performSegue(withIdentifier: "goToServices", sender: self)
        }
        listCategoriesTV.deselectRow(at: indexPath, animated: true)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "goToServices" {
            guard let services = segue.destination as? ListServices else {
                print("Destination not found")
                return
            }
            guard let categoryIndex = listCategoriesTV.indexPathForSelectedRow else {
                print("Category Index not found")
                return
            }
            services.category = categories[categoryIndex.row]
        }
    }

}
