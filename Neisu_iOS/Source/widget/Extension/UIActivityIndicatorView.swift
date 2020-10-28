//
//  UIActivityIndicatorView.swift
//  DodamDodam_iOS_V2
//
//  Created by Dev.Young on 31/07/2020.
//

import Foundation
import UIKit

// Using : https://stackoverflow.com/a/49929488
extension UIActivityIndicatorView {
    public static func customIndicator(at center: CGPoint) -> UIActivityIndicatorView {
        let indicator = UIActivityIndicatorView(frame: CGRect(x: 0.0, y: 0.0, width: 30.0, height: 30.0))
        indicator.layer.cornerRadius = 15
        indicator.center = center
        indicator.hidesWhenStopped = true
        indicator.style = UIActivityIndicatorView.Style.white
        indicator.backgroundColor = UIColor(red: 93/255, green: 110/255, blue: 245/255, alpha: 1)
        return indicator
    }
}
