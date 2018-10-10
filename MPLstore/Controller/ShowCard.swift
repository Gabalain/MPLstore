//
//  TableViewCell.swift
//  MPLstore
//
//  Created by Alain Gabellier on 04/10/2018.
//  Copyright © 2018 Alain Gabellier. All rights reserved.
//

import UIKit
import CoreGraphics

class ShowCard: UIViewController {

    var card: Card!
    var delegate: canReceiveUpdatedCard?
    
    @IBOutlet weak var brandLbl: UILabel!
    @IBOutlet weak var mainView: UIView!
    @IBOutlet weak var balanceLbl: UILabel!
    @IBOutlet weak var barCode: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        brandLbl.text = card.name
        mainView.layer.cornerRadius = 10
        balanceLbl.text = floatToString(card.balance, 2) + " MPLcoins"
        
        perform(#selector(scanCard), with: nil, afterDelay: 1)
    }

    @IBAction func dismissPressed(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
    
    @objc func scanCard() {
        
        let width = barCode.frame.width + 20
        let scanHeight: CGFloat = 60
        let centerX = barCode.frame.width / 2
        let centerY = (barCode.frame.height / 2) - 30
        
        let scanLine: UIView = UIView()
        barCode.addSubview(scanLine)
        scanLine.backgroundColor = UIColor.red
        
        let scanLineEndY = centerY + scanHeight
        
        scanLine.frame = CGRect(x: 0, y: 0, width: width, height: 2)
        scanLine.center = CGPoint(x: centerX, y: centerY)
        scanLine.isHidden = false
        weak var weakSelf = scanLine
        UIView.animate(withDuration: 1.0, delay: 0.0, options: [.autoreverse, .beginFromCurrentState], animations: {() -> Void in
            weakSelf!.center = CGPoint(x: weakSelf!.center.x, y: scanLineEndY)
        }, completion: { (finished: Bool) in
            scanLine.isHidden = true
            let randomAmount: Float = Float(arc4random_uniform(400)) + 100.0
            print(randomAmount)
            self.updateCardBalanceAndDismiss(card: self.card, amount: randomAmount / 100)
        })
        
    }
    
    func updateCardBalanceAndDismiss(card: Card, amount: Float) {
        updateCardBalance(card, amount)
        balanceLbl.text = floatToString(card.balance, 2) + " MPLcoins"
        
        delegate?.updatedCardReceived(card: card)
        
        perform(#selector(byeModal), with: nil, afterDelay: 1)
        
    }
    
    @objc func byeModal() {
        dismiss(animated: true, completion: nil)
    }

}
