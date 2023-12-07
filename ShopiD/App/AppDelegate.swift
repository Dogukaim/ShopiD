//
//  AppDelegate.swift
//  ShopiD
//
//  Created by Dogukaim on 1.




import UIKit
import Firebase
import GoogleSignIn
import FirebaseCore


@main
class AppDelegate: UIResponder, UIApplicationDelegate {
    
    
    public let signInConfig = GIDConfiguration(clientID: "547955988940-k7qo5pvcsoltfab82ujuj2h0v91ul30b.apps.googleusercontent.com")
    

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        FirebaseApp.configure()
        GIDSignIn.sharedInstance.restorePreviousSignIn { user, error in
           if error != nil || user == nil {
             // Show the app's signed-out state.
           } else {
             // Show the app's signed-in state.
           }
         }
         return true
    }


    
    func application(
      _ app: UIApplication,
      open url: URL, options: [UIApplication.OpenURLOptionsKey : Any] = [:]
    ) -> Bool {
      var handled: Bool

      handled = GIDSignIn.sharedInstance.handle(url)
      if handled {
        return true
      }

      // Handle other custom URL types.

      // If not handled by this app, return false.
      return false
    }
    
    
    
    
    
    
}


