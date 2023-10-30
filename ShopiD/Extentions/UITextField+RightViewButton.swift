//
//  UITextField+RightViewButton.swift
//  ShopiD
//
//  Created by Dogukaim on 5.09.2023.
//

import UIKit

extension UITextField {
    
    func setRightVewButton( _ button: UIButton, _ imageName: String) {

        self.rightView = button
        self.rightViewMode = .always
    }
}

