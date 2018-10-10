//
//  CustomTabBar.swift
//  MPLstore
//
//  Created by Alain Gabellier on 09/10/2018.
//  Copyright © 2018 Alain Gabellier. All rights reserved.
//

import UIKit

class CustomTabBar : UITabBar {
    // Can be set in Interface Builder
    @IBInspectable var height: CGFloat = 0.0
    
    override func sizeThatFits(_ size: CGSize) -> CGSize {
        var sizeThatFits = super.sizeThatFits(size)
        if height > 0.0 {
            sizeThatFits.height = height
        }
        return sizeThatFits
    }
    
    
}
