//
//  ServiceCell.swift
//  MPLstore
//
//  Created by Alain Gabellier on 08/10/2018.
//  Copyright © 2018 Alain Gabellier. All rights reserved.
//

import UIKit

class ServiceCell: UITableViewCell {
    
    @IBOutlet weak var imageIV: UIImageView!
    @IBOutlet weak var titleLbl: UILabel!
    @IBOutlet weak var personLbl: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }
    
    
}

