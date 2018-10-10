//
//  Person.swift
//  MPLstore
//
//  Created by Alain Gabellier on 07/10/2018.
//  Copyright © 2018 Alain Gabellier. All rights reserved.
//

import UIKit

class Profil: UIViewController {

    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var nameLbl: UILabel!
    @IBOutlet weak var imageIV: UIImageView!
    @IBOutlet weak var streetTF: UITextField!
    @IBOutlet weak var zipTF: UITextField!
    @IBOutlet weak var cityTF: UITextField!
    @IBOutlet weak var phoneTF: UITextField!
    @IBOutlet weak var mailTF: UITextField!
    @IBOutlet weak var profilPV: UIPickerView!
    @IBOutlet weak var star1IV: UIImageView!
    @IBOutlet weak var star2IV: UIImageView!
    @IBOutlet weak var star3IV: UIImageView!
    @IBOutlet weak var star4IV: UIImageView!
    @IBOutlet weak var star5IV: UIImageView!
    @IBOutlet weak var commentsLbl: UILabel!
    
    
    var person: Person = Person()
    let persons = getPersons()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    //    scrollView.contentSize = CGSize(width: self.view.frame.width, height: self.view.frame.height + 100)
        
        // Rounded image
        imageIV.layer.cornerRadius = imageIV.frame.width / 2
        imageIV.layer.masksToBounds = true

        let defaults = UserDefaults.standard
        let id = defaults.integer(forKey: "userId")
        updateProfilWithRow(id)

        self.profilPV.delegate = self
        self.profilPV.dataSource = self
        
        // Find Row of current profil
        profilPV.selectRow(id, inComponent: 0, animated: true)
    }
    
    @IBAction func walletPressed(_ sender: Any) {
        print("Wallet Pressed")
        DispatchQueue.main.async {
            self.performSegue(withIdentifier: "fromProfilToWallet", sender: nil)
        }
    }
    
    @IBAction func listCategoriesPressed(_ sender: Any) {
        print("Categories Pressed")
        DispatchQueue.main.async {
            self.performSegue(withIdentifier: "fromProfilToCategories", sender: nil)
        }
    }
}

extension Profil: UIPickerViewDelegate, UIPickerViewDataSource {
    // Pickers Fillin
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return persons.count
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return persons[row].name
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        updateProfilWithRow(row)
    }
    
    func updateProfilWithRow(_ row: Int) {
        let user = getPersonWithId(row)
        imageIV.image = UIImage(named: user.image)
        nameLbl.text = user.name
        commentsLbl.text = String(user.reviews) + " reviews"
        streetTF.text = user.street
        zipTF.text = String(user.zip)
        cityTF.text = user.city
        phoneTF.text = user.phone
        mailTF.text = user.mail
        
        star1IV.image = UIImage(named: "greenFullStar")
        star2IV.image = UIImage(named: "greenFullStar")
        star3IV.image = UIImage(named: "greenFullStar")
        star4IV.image = UIImage(named: "greenFullStar")
        star5IV.image = UIImage(named: "greenFullStar")
        switch user.rating {
        case 0..<5:
            star1IV.image = UIImage(named: "greenHalfStar")
            star2IV.image = UIImage(named: "greenEmptyStar")
            star3IV.image = UIImage(named: "greenEmptyStar")
            star4IV.image = UIImage(named: "greenEmptyStar")
            star5IV.image = UIImage(named: "greenEmptyStar")
        case 5..<10:
            star2IV.image = UIImage(named: "greenEmptyStar")
            star3IV.image = UIImage(named: "greenEmptyStar")
            star4IV.image = UIImage(named: "greenEmptyStar")
            star5IV.image = UIImage(named: "greenEmptyStar")
        case 10..<15:
            star2IV.image = UIImage(named: "greenHalfStar")
            star3IV.image = UIImage(named: "greenEmptyStar")
            star4IV.image = UIImage(named: "greenEmptyStar")
            star5IV.image = UIImage(named: "greenEmptyStar")
        case 15..<20:
            star3IV.image = UIImage(named: "greenEmptyStar")
            star4IV.image = UIImage(named: "greenEmptyStar")
            star5IV.image = UIImage(named: "greenEmptyStar")
        case 20..<25:
            star3IV.image = UIImage(named: "greenHalfStar")
            star4IV.image = UIImage(named: "greenEmptyStar")
            star5IV.image = UIImage(named: "greenEmptyStar")
        case 25..<30:
            
            star4IV.image = UIImage(named: "greenEmptyStar")
            star5IV.image = UIImage(named: "greenEmptyStar")
        case 30..<35:
            
            star4IV.image = UIImage(named: "greenHalfStar")
            star5IV.image = UIImage(named: "greenEmptyStar")
        case 35..<40:
            star5IV.image = UIImage(named: "greenEmptyStar")
        case 40..<45:
            star5IV.image = UIImage(named: "greenHalfStar")
        default:
            print("Bravo")
        }
        
        let defaults = UserDefaults.standard
        defaults.set(row, forKey: "userId")
    }

}
