//
//  newCard.swift
//  MPLstore
//
//  Created by Alain Gabellier on 05/10/2018.
//  Copyright © 2018 Alain Gabellier. All rights reserved.
//

import UIKit

class NewCard: UIViewController {

    var card: Card!
    var delegate: canReceiveUpdatedCard?
    
    @IBOutlet weak var brandLbl: UILabel!
    @IBOutlet weak var virtualCardText: UIButton!
    @IBOutlet weak var physicalCardText: UIButton!
    @IBOutlet weak var cancelBtn: UIButton!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        brandLbl.text = card.name
    }

    @IBAction func virtualCardPressed(_ sender: UIButton) {
        virtualCardText.isEnabled = false
        physicalCardText.isEnabled = false
        cancelBtn.isEnabled = false
        
        let currentWidth = sender.frame.width
        let wantedWidth = currentWidth * 2 + 30
        changeUIWidth(virtualCardText, wantedWidth, "trail")
        changeUIWidth(physicalCardText, 0, "lead")
        let currentHeight = sender.frame.height
        let wantedHeight = currentHeight + cancelBtn.frame.height + 20
        changeUIHeight(virtualCardText, wantedHeight, "bottom")
        changeUIHeight(cancelBtn, 0, "top")
        
        virtualCardText.setTitle("Good choice\nYou can use it right now",for: .normal)
        physicalCardText.setTitle("",for: .normal)
        cancelBtn.setTitle("",for: .normal)
        perform(#selector(sendCardAndDismiss), with: nil, afterDelay: 4)
    }
    
    @IBAction func physicalCardPressed(_ sender: UIButton) {
        virtualCardText.isEnabled = false
        physicalCardText.isEnabled = false
        cancelBtn.isEnabled = false
        
        let currentWidth = sender.frame.width
        let wantedWidth = currentWidth * 2 + 30
        changeUIWidth(physicalCardText, wantedWidth, "lead")
        changeUIWidth(virtualCardText, 0, "trail")
        let currentHeight = sender.frame.height
        let wantedHeight = currentHeight + cancelBtn.frame.height + 20
        changeUIHeight(physicalCardText, wantedHeight, "bottom")
        changeUIHeight(cancelBtn, 0, "top")
        
        physicalCardText.setTitle("You'll receive you card soon\nYou can use the virtual one right now",for: .normal)
        physicalCardText.titleLabel?.font = UIFont.boldSystemFont(ofSize: 16)
        virtualCardText.setTitle("",for: .normal)
        cancelBtn.setTitle("",for: .normal)
        perform(#selector(sendCardAndDismiss), with: nil, afterDelay: 4)
    }
    
    @IBAction func cancelPressed(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
    
    @objc func sendCardAndDismiss() {
        // iupdate card
        card.active = true
        card.balance = 0.0
        // Send to delegate (listCards)
        delegate?.updatedCardReceived(card: card)
        // Dismiss modal
        dismiss(animated: true, completion: nil)
    }
            
    func changeUIWidth(_ UI: UIView, _ width: CGFloat, _ direction: String) {
        var finalFrame = UI.frame
        finalFrame.size.width = width
        if direction == "lead" {
            finalFrame.origin.x = finalFrame.origin.x + UI.frame.width - width
        }
        UIView.animate(withDuration: 0.5, delay: 0, options: [.beginFromCurrentState, .curveLinear], animations: {
            UI.frame = finalFrame })
    }
    
    func changeUIHeight(_ UI: UIView, _ height: CGFloat, _ direction: String) {
        var finalFrame = UI.frame
        finalFrame.size.height = height
        if direction == "top" {
            print(finalFrame.origin.y, UI.frame.height, finalFrame.origin.y)
            finalFrame.origin.y = finalFrame.origin.y + UI.frame.height - height
        }
        UIView.animate(withDuration: 0.5, delay: 0, options: [.beginFromCurrentState, .curveLinear], animations: {
            UI.frame = finalFrame })
    }
}
