//
//  ServiceDetailViewController.swift
//  MPLstore
//
//  Created by Alain Gabellier on 09/10/2018.
//  Copyright © 2018 Alain Gabellier. All rights reserved.
//

import UIKit

class ServiceDetail: UIViewController {

    @IBOutlet weak var imageIV: UIImageView!
    @IBOutlet weak var titleLbl: UILabel!
    @IBOutlet weak var textLbl: UILabel!
    @IBOutlet weak var byPersonLbl: UILabel!
    @IBOutlet weak var personImageIV: UIImageView!
    @IBOutlet weak var star1IV: UIImageView!
    @IBOutlet weak var star2IV: UIImageView!
    @IBOutlet weak var star3IV: UIImageView!
    @IBOutlet weak var star4IV: UIImageView!
    @IBOutlet weak var star5IV: UIImageView!
    @IBOutlet weak var commentsLbl: UILabel!
    @IBOutlet weak var phoneIV: UIImageView!
    @IBOutlet weak var smsIV: UIImageView!
    @IBOutlet weak var mailIV: UIImageView!
    @IBOutlet weak var paiementLbl: UILabel!
    
    var service: Service!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        print("In View will appear")
        
        guard let category = service.category.first else { return }
        let categoryColor = hexStringToUIColor(hex: category.color)
        print("Name: ", category.name)
        
        if category.name == "Ads & Offers" {
            guard let person = service.person.first else { return }
            imageIV.image = UIImage(named: service.image)
            imageIV.layer.cornerRadius = imageIV.frame.width / 2
            imageIV.layer.masksToBounds = true
            titleLbl.text = service.name
            titleLbl.textColor = categoryColor
            textLbl.text = service.text
            textLbl.sizeToFit()
            byPersonLbl.text = "by " + person.name
            personImageIV.image = UIImage(named: person.image)
            personImageIV.layer.cornerRadius = personImageIV.frame.width / 2
            personImageIV.layer.masksToBounds = true
            star1IV.image = UIImage(named: "fullStar")
            star2IV.image = UIImage(named: "fullStar")
            star3IV.image = UIImage(named: "fullStar")
            star4IV.image = UIImage(named: "fullStar")
            star5IV.image = UIImage(named: "fullStar")
            switch person.rating {
            case 0..<5:
                star1IV.image = UIImage(named: "halfStar")
                star2IV.image = UIImage(named: "emptyStar")
                star3IV.image = UIImage(named: "emptyStar")
                star4IV.image = UIImage(named: "emptyStar")
                star5IV.image = UIImage(named: "emptyStar")
            case 5..<10:
                star2IV.image = UIImage(named: "emptyStar")
                star3IV.image = UIImage(named: "emptyStar")
                star4IV.image = UIImage(named: "emptyStar")
                star5IV.image = UIImage(named: "emptyStar")
            case 10..<15:
                star2IV.image = UIImage(named: "halfStar")
                star3IV.image = UIImage(named: "emptyStar")
                star4IV.image = UIImage(named: "emptyStar")
                star5IV.image = UIImage(named: "emptyStar")
            case 15..<20:
                star3IV.image = UIImage(named: "emptyStar")
                star4IV.image = UIImage(named: "emptyStar")
                star5IV.image = UIImage(named: "emptyStar")
            case 20..<25:
                star3IV.image = UIImage(named: "halfStar")
                star4IV.image = UIImage(named: "emptyStar")
                star5IV.image = UIImage(named: "emptyStar")
            case 25..<30:
                
                star4IV.image = UIImage(named: "emptyStar")
                star5IV.image = UIImage(named: "emptyStar")
            case 30..<35:
                
                star4IV.image = UIImage(named: "halfStar")
                star5IV.image = UIImage(named: "emptyStar")
            case 35..<40:
                star5IV.image = UIImage(named: "emptyStar")
            case 40..<45:
                star5IV.image = UIImage(named: "halfStar")
            default:
                print("Bravo")
            }
            commentsLbl.text = String(person.reviews) + " reviews"
            paiementLbl.text = "Send a payment to " + person.name
            paiementLbl.textColor = categoryColor
            
        } else if category.name == "Associations" {
            imageIV.image = UIImage(named: service.image)
            imageIV.layer.cornerRadius = imageIV.frame.width / 2
            imageIV.layer.masksToBounds = true
            titleLbl.text = service.name
            titleLbl.textColor = categoryColor
            textLbl.text = service.text
            byPersonLbl.isHidden = true
            personImageIV.isHidden = true
            personImageIV.frame = CGRect(x: 0, y: 0, width: 0, height: 0)
            star1IV.isHidden = true
            star2IV.isHidden = true
            star3IV.isHidden = true
            star4IV.isHidden = true
            star5IV.isHidden = true
            commentsLbl.isHidden = true
            phoneIV.isHidden = true
            smsIV.isHidden = true
            mailIV.isHidden = true
            paiementLbl.text = "Send a payment to " + service.name
            paiementLbl.textColor = categoryColor
        }
    }
}
