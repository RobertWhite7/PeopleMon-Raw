//
//  PersonCell.swift
//  PeopleMon
//
//  Created by Robert White on 11/14/16.
//  Copyright © 2016 Teky. All rights reserved.
//

import UIKit
import AFDateHelper

class PersonCell: UITableViewCell {

    @IBOutlet weak var nameLabel: UILabel!
   
    
    var person: Account!
    
    func setupCell(person: Account) {
        self.person = person
        nameLabel.text = person.username
        
    
        
    /*    if let image = Utils.imageFromString(imageString: person.avatar) {
            avatar.image = image
        } else {
            avatar.image = #imageLiteral(resourceName: "Defaultimage")
        }
  */
    }
}
