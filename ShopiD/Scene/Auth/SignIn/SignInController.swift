//
//  SignInController.swift
//  ShopiD
//
//  Created by Dogukaim on 1.09.2023.
//

import Foundation
import UIKit
import Firebase
import AuthenticationServices




class SignInController: UIViewController {
    
    @IBOutlet weak var emailText: UITextField!
    @IBOutlet weak var passwordTextt: UITextField!
    @IBOutlet weak var loginButton: UIButton!
    @IBOutlet weak var phoneButton: UIButton!
    @IBOutlet weak var googleButton: UIButton!
    @IBOutlet weak var appleButton: UIButton!
    @IBOutlet weak var registerButton: UIButton!
    
    @IBOutlet weak var eyesButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        configureUI()
        
    }
    
    private func configureUI() {
        loginButton.layer.cornerRadius = 40
        phoneButton.layer.cornerRadius = 18
        googleButton.layer.cornerRadius = 18
        appleButton.layer.cornerRadius = 18
        emailText.layer.cornerRadius = 13
        registerButton.layer.cornerRadius = 13
        eyesButton.layer.cornerRadius = 10
        passwordTextt.layer.cornerRadius = 13
    }
    
    
    
    @IBAction func eyesButtonTapped(_ sender: Any) {
        
        
    }
    
    
    @IBAction func loginButtonTapped(_ sender: Any) {
        if emailText.text != nil && passwordTextt.text != nil {
            
            Auth.auth().signIn(withEmail: emailText.text!, password: passwordTextt.text!) {
                data, error in
                if error != nil {
//                    AlertMessage.alertMessage(title: "Error", message: "Email or password is incorrect", vc: self)
//
                } else {
                    let controller = self.storyboard?.instantiateViewController(withIdentifier: "HomeNNC") as! UITabBarController
                    controller.modalPresentationStyle = .fullScreen
                    self.present(controller,animated: true,completion: nil)
                    
                }
            }
        }
    }
    
    
    @IBAction func phoneButtonTapped(_ sender: Any) {
        
    }
    
    @IBAction func googleButtonTapped(_ sender: Any) {
        
    }
    
    @IBAction func appleButtonTapped(_ sender: Any) {
        
    }
    
    @IBAction func regjsterButtonTapped(_ sender: Any) {
        let controller = self.storyboard?.instantiateViewController(withIdentifier: "SignUpController") as! SignUpController
        self.present(controller,animated: true)
    }
    
}
