//
//  UIImageView+Extension.swift
//  SeSac_Week5-2
//
//  Created by youngjoo on 1/28/24.
//

import UIKit

extension UIImageView {
    
    func configureImageView(name: String, cornerRadius: CGFloat) {
        self.image = UIImage(named: name)
        self.clipsToBounds = true
        self.layer.cornerRadius = cornerRadius
    }
    
}
