//
//  TableViewCell.swift
//  MPLstore
//
//  Created by Alain Gabellier on 04/10/2018.
//  Copyright © 2018 Alain Gabellier. All rights reserved.
//

import UIKit

class ShowCard: UIViewController {

    var brandName: String = ""
    var balance: Float = 0.0
    
    @IBOutlet weak var brandLbl: UILabel!
    @IBOutlet weak var mainView: UIView!
    @IBOutlet weak var balanceLbl: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        brandLbl.text = brandName
        mainView.layer.cornerRadius = 10
        balanceLbl.text = floatToString(balance, 2) + " MPLcoins"
        
    }

    @IBAction func dismissPressed(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
    

}
