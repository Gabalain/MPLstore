//
//  CommonFuncs.swift
//  MPLstore
//
//  Created by Alain Gabellier on 04/10/2018.
//  Copyright © 2018 Alain Gabellier. All rights reserved.
//

import Foundation

func floatToString(_ number: Float, _ digits: Int) -> String {
    if (number == 0) { return "0,00" }
    let formatter = NumberFormatter()
    formatter.decimalSeparator = ","
    formatter.groupingSeparator = " "
    formatter.minimumFractionDigits = digits
    formatter.maximumFractionDigits = digits
    return formatter.string(from: NSNumber(value: number)) ?? "\(number)"
}
