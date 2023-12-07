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
        guard let email = emailTextt.text, !email.isEmpty else {
               // E-posta geçerli değil
               print("Geçerli bir e-posta girin.")
               return
           }

           guard let password = passwordTxt.text, !password.isEmpty else {
               // Şifre geçerli değil
               print("Geçerli bir şifre girin.")
               return
           }

           Auth.auth().createUser(withEmail: email, password: password) { authDataResult, error in
               if let error = error {
                   print("Kayıt işlemi başarısız: \(error.localizedDescription)")
                   return
               }

               if let authData = authDataResult {
                   print("Kullanıcı başarıyla kaydedildi. E-posta: \(authData.user.email ?? "")")

                   // Kullanıcı bilgilerini veritabanına ekleyin
                   let dict: [String: Any] = [
                       "uid": authData.user.uid,
                       "email": authData.user.email ?? "",
                       "profileImageUrl": "", // Profil resmi URL'si, eğer varsa ekleyin
                       "status": "" // Kullanıcının durumu, eğer varsa ekleyin
                   ]

                   Database.database().reference().child("users").child(authData.user.uid).updateChildValues(dict) { error, ref in
                       if let error = error {
                           print("Kullanıcı bilgileri veritabanına eklenirken hata oluştu: \(error.localizedDescription)")
                       } else {
                           print("Kullanıcı bilgileri başarıyla veritabanına eklendi.")
                       }
                   }
               }
           }
        
    }
    

    
    func updateUserProfile(uid: String) {
           let dict: [String: Any] = [
               "uid": uid,
               "email": emailTextt.text ?? "",
               "fullName": fullNameText.text ?? "",
               "profileImageUrl": "", // Profil resmi URL'si eklenebilir
               "status": "" // Kullanıcının durumu eklenebilir
           ]
           
           Database.database().reference().child("users").child(uid).updateChildValues(dict) { error, _ in
               if let error = error {
                   print("Hata: \(error.localizedDescription)")
               } else {
                   print("Kullanıcı profili başarıyla güncellendi.")
               }
           }
       }
    
    
    @IBAction func loginSignButTap(_ sender: Any) {
        let controller = self.storyboard?.instantiateViewController(withIdentifier: "SignInController") as! SignInController
        controller.modalPresentationStyle = .fullScreen
        controller.modalTransitionStyle = .flipHorizontal
        self.present(controller,animated: true)
    }
    
}
