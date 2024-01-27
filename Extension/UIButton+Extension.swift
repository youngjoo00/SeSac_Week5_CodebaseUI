//
//  UIButton+Extension.swift
//  SeSac_Week5-2
//
//  Created by youngjoo on 1/27/24.
//

import UIKit

extension UIButton {
    
    func configureBtn(image: UIImage?, title: String, backgroundColor: UIColor, textColor: UIColor, font: UIFont, cornerRadius: CGFloat) {
        self.setImage(image, for: .normal)
        self.setTitle(title, for: .normal)
        self.backgroundColor = backgroundColor
        self.setTitleColor(textColor, for: .normal)
        self.layer.cornerRadius = cornerRadius
        self.titleLabel?.font = font
    }
}
