//
//  listServices.swift
//  MPLstore
//
//  Created by Alain Gabellier on 07/10/2018.
//  Copyright © 2018 Alain Gabellier. All rights reserved.
//

import UIKit
import RealmSwift

class ListServices: UIViewController, UITableViewDelegate, UITableViewDataSource {

    @IBOutlet weak var imageIV: UIImageView!
    @IBOutlet weak var listServicesTV: UITableView!
    @IBOutlet weak var serviceTextLbl: UILabel!
    @IBOutlet weak var serviceSmallTextLbl: UILabel!
    @IBOutlet weak var separatorLbl: UILabel!
    
    var category: Category!
    var services: Results<Service>!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        listServicesTV.delegate = self
        listServicesTV.dataSource = self

        imageIV.image = UIImage(named: category.icon)
        serviceTextLbl.text = category.name
        serviceTextLbl.textColor = hexStringToUIColor(hex: category.color)
        serviceSmallTextLbl.text = category.text
        separatorLbl.backgroundColor = hexStringToUIColor(hex: category.color)
        
        services = getServicesOfCategory(category)
        
        // Do any additional setup after loading the view.
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return services.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = listServicesTV.dequeueReusableCell(withIdentifier: "serviceCell", for: indexPath) as! ServiceCell
        
        let service = services[indexPath.row]
        cell.imageIV.image = UIImage(named: service.image)
        // Rounded image
        cell.imageIV.layer.cornerRadius = cell.imageIV.frame.width / 2
        cell.imageIV.layer.masksToBounds = true

        cell.titleLbl.text = service.name
        cell.titleLbl.textColor = hexStringToUIColor(hex: category.color)
        
        if let person = service.person.first {
            cell.personLbl.text = "by " + person.name
        } else {
            cell.personLbl.text = ""
        }
        
        tableView.rowHeight = 150
        return cell
    }
    
    // Segue
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        performSegue(withIdentifier: "detailService", sender: self)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "detailService" {
            guard let detailServiceView = segue.destination as? ServiceDetail else {
                print("Destination not found")
                return
            }
            guard let serviceIndex = listServicesTV.indexPathForSelectedRow else {
                print("Service Index not found")
                return
            }
            detailServiceView.service = services[serviceIndex.row]
        }
    }

}
