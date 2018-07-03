//
//  RoundButton.swift
//  Park.ly
//
//  Created by Константин Клинов on 7/3/18.
//  Copyright © 2018 Константин Клинов. All rights reserved.
//

import UIKit

class RoundButton: UIButton {

    override func awakeFromNib() {
        self.layer.cornerRadius = self.frame.height / 2
        
        self.layer.shadowRadius = 20
        self.layer.shadowOpacity = 0.5
        self.layer.shadowColor = UIColor.black.cgColor
    }

}
