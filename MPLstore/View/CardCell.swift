//
//  CardCell.swift
//  MPLstore
//
//  Created by Alain Gabellier on 04/10/2018.
//  Copyright © 2018 Alain Gabellier. All rights reserved.
//

import UIKit

class CardCell: UITableViewCell {

    @IBOutlet weak var cardIV: UIImageView!
    @IBOutlet weak var nameLbl: UILabel!
    @IBOutlet weak var balanceLbl: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    

}
