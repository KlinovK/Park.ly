//
//  ImageViewRtx.swift
//  Park.ly
//
//  Created by Константин Клинов on 7/3/18.
//  Copyright © 2018 Константин Клинов. All rights reserved.
//

import UIKit

class ImageViewRtx: UIImageView {

    override func awakeFromNib() {
        
        self.layer.shadowRadius = 20
        self.layer.shadowOpacity = 0.5
        self.layer.shadowColor = UIColor.black.cgColor
    }

}
