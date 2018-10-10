//
//  chatInDrive.swift
//  MPLstore
//
//  Created by Alain Gabellier on 08/10/2018.
//  Copyright © 2018 Alain Gabellier. All rights reserved.
//

import UIKit

class ChatInDrive: UIViewController {

    @IBOutlet weak var imageIV: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Rounded image
        imageIV.layer.cornerRadius = imageIV.frame.width / 2
        imageIV.layer.masksToBounds = true
    }

}

