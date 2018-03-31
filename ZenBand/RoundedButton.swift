//
//  RoundedButton.swift
//  ZenBand
//
//  Created by Arham Raza on 2018-03-31.
//  Copyright © 2018 Capstone Project. All rights reserved.
//

import Foundation
import UIKit

class RoundedButton: UIButton {
    override func awakeFromNib() {
        super.awakeFromNib()
        
        layer.borderWidth = 1/UIScreen.main.nativeScale
        contentEdgeInsets = UIEdgeInsets(top: 0, left: 16, bottom: 0, right: 16)
        titleLabel?.adjustsFontForContentSizeCategory = true
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        layer.cornerRadius = frame.height/2
        layer.borderColor = tintColor.cgColor
    }
}
