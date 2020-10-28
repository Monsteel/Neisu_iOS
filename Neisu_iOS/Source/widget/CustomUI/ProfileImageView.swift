//
//  ProfileImageView.swift
//  DodamDodam_iOS_V2
//
//  Created by Dev.Young on 2020/09/12.
//

import UIKit

class ProfileImageView: UIImageView {
    override func layoutSubviews() {
        self.layer.borderWidth = 1.0
        self.layer.masksToBounds = false
        self.layer.borderColor = UIColor.white.cgColor
        self.layer.cornerRadius = self.frame.size.width / 2
        self.clipsToBounds = true
    }
}
