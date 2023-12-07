//
//  SignInController.swift
//  ShopiD
//
//  Created by Dogukaim on 1.09.2023.
//


import UIKit
import Firebase
import GoogleSignIn
import FirebaseDatabase
import FirebaseAuth





class SignInController: UIViewController{
    
 
    //MARK: - Google SignIn Manager
    private var  googleSignInManager: GIDSignIn!
    
    var passwordSecure = true
    static let signInConfig = GIDConfiguration(clientID: "547955988940-k7qo5pvcsoltfab82ujuj2h0v91ul30b.apps.googleusercontent.com")
    
    @IBOutlet weak var emailText: UITextField!
    @IBOutlet weak var passwordTextt: UITextField!
    @IBOutlet weak var loginButton: UIButton!
    @IBOutlet weak var eyesButton: UIButton!
    @IBOutlet weak var registerButt: UIButton!
    
    
    private let signInViewModel = SignInViewModel()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    
        GIDSignIn.sharedInstance.restorePreviousSignIn { user, error in
            if let error = error {
                print("Error restoring previous sign-in: \(error.localizedDescription)")
            }
        }
       
//        GIDSignIn.sharedInstance.signIn(withPresenting: self)
        
        GIDSignIn.sharedInstance.configuration = SignInController.signInConfig
            
    
    }
    

    
    
    
    
    
    @IBAction func loginButtonTapped(_ sender: Any) {
        if let email = emailText.text, let password = passwordTextt.text {
                   Auth.auth().signIn(withEmail: email, password: password) { _, error in
                       if let error = error {
                           AlertMessage.alertMessage(title: "Error", message: "Email or password is incorrect", vc: self)
                           print("Error signing in: \(error.localizedDescription)")
                       } else {
                           let controller = self.storyboard?.instantiateViewController(withIdentifier: "HomeTabbar") as! UIViewController
                           controller.modalPresentationStyle = .fullScreen
                           self.present(controller, animated: true, completion: nil)
                       }
                   }
               }
    }
    
    
    
    
    
    @IBAction func googleButtonTapped(_ sender: Any) {

        
        GIDSignIn.sharedInstance.signIn(withPresenting: self) { user, error in
            if let error = error {
                // Handle error if sign-in fails
                print("Google Sign-In error: \(error.localizedDescription)")
                return
            }
            
            // User is signed in successfully
            guard let idToken = user?.user.idToken,
                  let accessToken = user?.user.accessToken else {
                // Handle case when authentication data is missing
                print("Google Sign-In failed: No authentication data")
                return
            }
            
            // Create a GoogleAuthProvider credential using the obtained tokens
            let credential = GoogleAuthProvider.credential(withIDToken: idToken.tokenString,
                                                           accessToken: accessToken.tokenString)
            
            // Perform sign-in with the credential using your own services or backend
          
            self.signInWithCredential(credential)
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

             print("Full Name: \(fullName ?? ""), Email Address: \(emailAdress ?? "")")

             // Gerekirse kullanıcı bilgilerini kullanabilirsiniz.
             // Örnek: self.navigateToHomeScreen()
    }
    
    
    private func signInWithCredential(_ credential: AuthCredential) {
        Auth.auth().signIn(with: credential) { [weak self] authResult, error in
                  if let error = error {
                      print("Failed to sign in with Google credential: \(error.localizedDescription)")
                  } else {
                      self?.navigateToHomeScreen()
                  }
              }
    }

    
    func navigateToHomeScreen() {
        if let ViewController = self.storyboard?.instantiateViewController(withIdentifier: "HomeTabbar") {
                // ViewController'ı modal olarak başlat
                ViewController.modalPresentationStyle = .fullScreen
                self.present(ViewController, animated: true, completion: nil)
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
    
    
    
    

   
    
}
    
    
    
    

