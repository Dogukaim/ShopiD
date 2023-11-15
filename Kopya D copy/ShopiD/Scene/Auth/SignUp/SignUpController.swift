//
//  SignUpController.swift
//  ShopiD
//
//  Created by Dogukaim on 4.09.2023.
//

import UIKit
import FirebaseAuth
import FirebaseDatabase


class SignUpController: UIViewController {

    @IBOutlet weak var fullNameText: UITextField!
    @IBOutlet weak var emailTextt: UITextField!
    @IBOutlet weak var passwordTxt: UITextField!
    @IBOutlet weak var signUpButton: UIButton!
    @IBOutlet weak var loginSignButt: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()

    }


    @IBAction func signUpButtonTap(_ sender: Any) {
//        Auth.auth().createUser(withEmail: "sfsakja@asfjl.com", password: "123456") { authDataResult, error in
//            if error != nil {
//                print(error!.localizedDescription)
//                return
//            }
//            if let authData = authDataResult {
//                print(authData.user.email)
//                let dict: Dictionary<String,Any> = [
//                    "uid": authData.user.uid,
//                    "email": authData.user.email, 
//                    "profileImageUr1": "",
//                    "status": ""
//                ]
//                
//                Database.database().reference().child("users").child(authData.user.uid).updateChildValues(dict) { error , ref in
//                    if error != nil {
//                        print("Done")
//                    }
//                }
//            }
//        }
        
    }
    

    @IBAction func loginSignButTap(_ sender: Any) {
        let controller = self.storyboard?.instantiateViewController(withIdentifier: "SignInController") as! SignInController
        self.present(controller,animated: true)
    }
    
}
