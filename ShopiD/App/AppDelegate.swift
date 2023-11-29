//
//  AppDelegate.swift
//  ShopiD
//
//  Created by Dogukaim on 1.09.2023.
//
//
//import UIKit
//import FirebaseCore
//import Firebase
//import GoogleSignIn
//
//
//
//@main
//class AppDelegate: UIResponder, UIApplicationDelegate {
//
//    public let signInConfig = GIDConfiguration(clientID: "547955988940-k7qo5pvcsoltfab82ujuj2h0v91ul30b.apps.googleusercontent.com")
//
//
//    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
//
//
//        FirebaseApp.configure()
//
//
//
//
//        GIDSignIn.sharedInstance.delegate = self
//
//        //  GoogleSignIn
//        if let clientID = FirebaseApp.app()?.options.clientID {
//            let _ = GIDConfiguration(clientID: clientID)
//        }
//
//
//
//
//        let gIdConfiguration = GIDConfiguration(clientID: "clientID", serverClientID: "serverClientID")
//
//        GIDSignIn.sharedInstance.configuration = gIdConfiguration
//        FirebaseApp.app()?.options.clientID =  gIdConfiguration.clientID
//
//        FirebaseApp.app()?.options.clientID = GIDSignIn.sharedInstance.configuration?.clientID
//
//
//
//
//
//        return true
//    }
//
//
//
//
//
//    open func application(_ app: UIApplication, open url: URL, options: [UIApplication.OpenURLOptionsKey : Any] = [:]) -> Bool {
//
//        return GIDSignIn.sharedInstance.handle(url)
//    }
//
//
//
//
//
//}

import UIKit
import Firebase
import GoogleSignIn
import FirebaseCore

@main
class AppDelegate: UIResponder, UIApplicationDelegate {

    public let signInConfig = GIDConfiguration(clientID: "547955988940-k7qo5pvcsoltfab82ujuj2h0v91ul30b.apps.googleusercontent.com")

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        FirebaseApp.configure()

//        // FirebaseApp'in clientID'sini GIDSignInConfiguration'a atayın
//        if let clientID = FirebaseApp.app()?.options.clientID {
//            let gIdConfiguration = GIDConfiguration(clientID: clientID)
//            GIDSignIn.sharedInstance.configuration = gIdConfiguration
//        }
//        
        GIDSignIn.sharedInstance.restorePreviousSignIn { user, error in
            if error != nil || user == nil {
                // Show the app's signed-out state.
            } else {
                // Show the app's signed-in state.
            }
        }
        
        return true
    }

    // Google Sign-In için callback işlemleri

    func application(_ app: UIApplication, open url: URL,
              options: [UIApplication.OpenURLOptionsKey : Any] = [:]) -> Bool {
      var handled: Bool

      handled = GIDSignIn.sharedInstance.handle(url)
      if handled {
        return true
      }

      // Handle other custom URL types.

      // If not handled by this app, return false.
      return false
    }
    // Google Sign-In işlemi başarılı olduğunda çağrılır
    func sign(_ signIn: GIDSignIn!, didSignInFor user: GIDGoogleUser!, withError error: Error!) {
        if let error = error {
            print("Google Sign-In hatası: \(error.localizedDescription)")
            return
        }

    }
    
    
   
    
}




