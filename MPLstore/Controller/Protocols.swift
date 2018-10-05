//
//  Protocols.swift
//  MPLstore
//
//  Created by Alain Gabellier on 05/10/2018.
//  Copyright © 2018 Alain Gabellier. All rights reserved.
//

import Foundation

protocol canReceiveUpdatedCard {
    func updatedCardReceived(card: Card)
}
