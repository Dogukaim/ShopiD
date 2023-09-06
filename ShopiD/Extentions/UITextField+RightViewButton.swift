//
//  UITextField+RightViewButton.swift
//  ShopiD
//
//  Created by Dogukaim on 5.09.2023.
//

import UIKit

extension UITextField {
    
    func setRightVewButton( _ button: UIButton, _ imageName: String) {
//        button.setImage(UIImage(systemName: imageName), for: .normal)
//        button.frame = CGRect(x: CGFloat(self.frame.size.width - 25), y: CGFloat(5), width: CGFloat(25), height: CGFloat(25))
        self.rightView = button
        self.rightViewMode = .always
    }
}

