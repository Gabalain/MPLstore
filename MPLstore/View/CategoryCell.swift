//
//  categoryCell.swift
//  MPLstore
//
//  Created by Alain Gabellier on 05/10/2018.
//  Copyright © 2018 Alain Gabellier. All rights reserved.
//

import UIKit

class CategoryCell: UITableViewCell {
    
    @IBOutlet weak var iconIV: UIImageView!
    @IBOutlet weak var textLbl: UILabel!
    @IBOutlet weak var nameLbl: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }
    
    
}
