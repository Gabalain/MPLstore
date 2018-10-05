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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        brandLbl.text = card.name
        mainView.layer.cornerRadius = 10
        balanceLbl.text = floatToString(card.balance, 2) + " MPLcoins"
        
        perform(#selector(scanCard), with: nil, afterDelay: 1)
    }

    @IBAction func dismissPressed(_ sender: Any) {
        print("card is passed: ", card.balance)
        delegate?.updatedCardReceived(card: card)
        
        dismiss(animated: true, completion: nil)
    }
    
    @objc func scanCard() {
 //       drawRect(rect: mainView.frame)
//        drawLine(ofColor: UIColor.red, inView: mainView)
        
        let centerX = mainView.frame.width / 2
        let centerY = mainView.frame.height / 2 - 15
        let width = mainView.frame.width - 80
        
        let scanLine: UIView = UIView()
        mainView.addSubview(scanLine)
        scanLine.backgroundColor = UIColor.red
        
        let scanLineEndY = mainView.frame.origin.y + 30
        
        scanLine.frame = CGRect(x: 0, y: 0, width: width, height: 2)
        scanLine.center = CGPoint(x: centerX, y: centerY)
        scanLine.isHidden = false
        weak var weakSelf = scanLine
        UIView.animate(withDuration: 1.0, delay: 0.0, options: [.autoreverse, .beginFromCurrentState], animations: {() -> Void in
            weakSelf!.center = CGPoint(x: weakSelf!.center.x, y: scanLineEndY)
        }, completion: { (finished: Bool) in
            scanLine.isHidden = true
            let randomAmount: Float = Float(arc4random_uniform(400))
            print(randomAmount)
            self.updateCardBalance(card: self.card, amount: randomAmount / 100)
        })
        
    }
    
    func updateCardBalance(card: Card, amount: Float) {
        card.balance = card.balance + amount
        balanceLbl.text = floatToString(card.balance, 2) + " MPLcoins"
    }

}
