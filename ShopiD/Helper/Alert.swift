//
//  Alert.swift
//  ShopiD
//
//  Created by Dogukaim on 27.11.2023.
//

import Foundation

import UIKit

final class AlertMessage {
    
    static func alertMessage(title: String, message: String, vc: UIViewController) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: UIAlertController.Style.actionSheet)
        let alertAction = UIAlertAction(title: "OK", style: UIAlertAction.Style.destructive, handler: nil)
        alert.addAction(alertAction)
        vc.present(alert, animated: true)
    }
}
