//
//  SceneDelegate.swift
//  ShopiD
//
//  Created by Dogukaim on 1.09.2023.
//

import UIKit
import FirebaseAuth
import FirebaseCore
import GoogleSignIn

class SceneDelegate: UIResponder, UIWindowSceneDelegate {

    var window: UIWindow?

       func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
           guard let scene = (scene as? UIWindowScene) else { return }
//           
//           
//           
//           let window = UIWindow(windowScene: scene )
//           let rootViewController: UIViewController
//
//           if let currentUser = Auth.auth().currentUser {
//               if currentUser.isEmailVerified {
//                   rootViewController = HomeController()
//               } else {
//                   // Kullanıcı email doğrulanmamışsa SignInController'ı kullanabilirsiniz.
//                   let signInController = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "SignInController") as! SignInController
//                   rootViewController = UINavigationController(rootViewController: signInController)
//               }
//           } else {
//               // Hiçbir kullanıcı oturumu açmamışsa OnboardingController'ı kullanabilirsiniz.
//               let onboardingController = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "OnboardingController") as! OnboardingController
//               rootViewController = UINavigationController(rootViewController: onboardingController)
//           }
//
//           window.rootViewController = rootViewController
//           window.makeKeyAndVisible()
//           self.window = window
       }
    
    

    
    
    
    func scene(_ scene: UIScene, openURLContexts URLContexts: Set<UIOpenURLContext>) {
        guard (URLContexts.first?.url) != nil else {
            return
        }
        
    }


}

