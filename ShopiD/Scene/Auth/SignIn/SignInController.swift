//
//  SignInController.swift
//  ShopiD
//
//  Created by Dogukaim on 1.09.2023.
//

import Foundation
import UIKit
import Firebase
import GoogleSignIn
import FirebaseDatabase




class SignInController: UIViewController{
    
 
    //MARK: - Google SignIn Manager
    private let googleSignInManager = GIDSignIn.sharedInstance
    
    var passwordSecure = true
    static let signInConfig = GIDConfiguration(clientID: "547955988940-k7qo5pvcsoltfab82ujuj2h0v91ul30b.apps.googleusercontent.com")
    
    @IBOutlet weak var emailText: UITextField!
    @IBOutlet weak var passwordTextt: UITextField!
    @IBOutlet weak var loginButton: UIButton!
    @IBOutlet weak var eyesButton: UIButton!
    @IBOutlet weak var registerButt: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        
       
        
    }
    

    
    
    
    
    
    @IBAction func loginButtonTapped(_ sender: Any) {
        if let email = emailText.text, let password = passwordTextt.text {
                   Auth.auth().signIn(withEmail: email, password: password) { _, error in
                       if let error = error {
                           AlertMessage.alertMessage(title: "Error", message: "Email or password is incorrect", vc: self)
                           print("Error signing in: \(error.localizedDescription)")
                       } else {
                           let controller = self.storyboard?.instantiateViewController(withIdentifier: "HomeNNC") as! UITabBarController
                           controller.modalPresentationStyle = .fullScreen
                           self.present(controller, animated: true, completion: nil)
                       }
                   }
               }
    }
    
    
    
    
    
    @IBAction func googleButtonTapped(_ sender: Any) {
        
//        let signInViewModel = SignInViewModel()
//             signInViewModel.credentialHandler = { [weak self] credential, error in
//                 if let error = error {
//                     print("Failed to sign in with Google: \(error.localizedDescription)")
//                     // Handle the error
//                 } else if let credential = credential {
//                     // Kullanıcı başarıyla Google ile giriş yaptı
//                     self?.signInWithCredential(credential)
//                 }
//             }
//             signInViewModel.getGoogleCredential(self)
        
     
    
        
    }
    
    private func signInWithCredential(_ credential: AuthCredential) {
            Auth.auth().signIn(with: credential) { [weak self] authResult, error in
                if let error = error {
                    print("Failed to sign in with Google credential: \(error.localizedDescription)")
                    // Handle the error
                } else {
                    // Kullanıcı başarıyla giriş yaptı
                    let controller = self?.storyboard?.instantiateViewController(withIdentifier: "HomeNNC") as! UITabBarController
                    controller.modalPresentationStyle = .fullScreen
                    self?.present(controller, animated: true, completion: nil)
                }
            }
        }

    
    
    
    
    
    
    
    
    
    
    
    @IBAction func regjsterButtonTapped(_ sender: Any) {
        let controller = self.storyboard?.instantiateViewController(withIdentifier: "SignUpController") as! SignUpController
        controller.modalPresentationStyle = .fullScreen
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
    
    
    
    
    func sign(_ signIn: GIDSignIn!, didSignInFor user: GIDGoogleUser!, withError error: Error!) {
        if let error = error {
            print("Failed to sign in with Google: \(error.localizedDescription)")
            return
        }

        guard let user = user else {
            print("No user information received from Google.")
            return
        }

        let emailAdress = user.profile?.email
        let userID = user.userID
        let fullName = user.profile?.name
        let givenName = user.profile?.givenName
        let familyName = user.profile?.familyName
        let profilePicUrl = user.profile?.imageURL(withDimension: 320)

        print("full name \(fullName ?? ""), emailAddress: \(emailAdress ?? "")")
    }
    
}
    
    
    
    

