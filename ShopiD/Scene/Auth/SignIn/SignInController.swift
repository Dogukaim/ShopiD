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
import GoogleSignIn
import FirebaseDatabase




class SignInController: UIViewController {
    
    var passwordSecure = true
    let signInConfig = GIDConfiguration(clientID: "547955988940-k7qo5pvcsoltfab82ujuj2h0v91ul30b.apps.googleusercontent.com")
    
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
        
        GIDSignIn.sharedInstance.signIn(withPresenting: self) { user, error in
           guard error == nil else { return }

//            guard let user = user else { return }
//            let emailAdress = user.profile?.email
//            let userID = user.userID
//            let fullName = user.profile?.name
//            let givenName = user.profile?.givenName
//            let familyName = user.profile?.familyName
//
//
//            let profilePicUrl = user.profile?.imageURL(withDimension: 320)
//
//            print("full name \(fullName), emailAddress: \(emailAdress)")
         }
        
        
        
    }
    
    @IBAction func appleButtonTapped(_ sender: Any) {
        
    }
    
    @IBAction func regjsterButtonTapped(_ sender: Any) {
        let controller = self.storyboard?.instantiateViewController(withIdentifier: "SignUpController") as! SignUpController
        self.present(controller,animated: true)
    }
    
    
    //MARK: - PasswordEyeButton Toggle
    
    func passwordEyeButtonToggle() {
        if passwordSecure {
            passwordTextt.isSecureTextEntry = false
            passwordTextt.setRightVewButton(eyesButton, "eye")
        } else {
            passwordTextt.isSecureTextEntry = true
            passwordTextt.setRightVewButton(eyesButton, "eye.slash")
        }
        passwordSecure = !passwordSecure
    }
    
    @IBAction func eyesPasww(_ sender: UIButton) {
        
        if sender.tag == 0 {
            //Show
            sender.tag = 1
            passwordTextt.isSecureTextEntry = false
            eyesButton.setImage(UIImage(systemName: "eye.slash"), for: .normal)
            
        }else if sender.tag == 1 {
            sender.tag = 0
            passwordTextt.isSecureTextEntry = true
            eyesButton.setImage(UIImage(systemName: "eye"), for: .normal)
        }
    }
    
    
    
    
    
}
