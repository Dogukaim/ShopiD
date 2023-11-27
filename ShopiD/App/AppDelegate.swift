//
//  AppDelegate.swift
//  ShopiD
//
//  Created by Dogukaim on 1.09.2023.
//

import UIKit
import FirebaseCore
import Firebase
import GoogleSignIn

    

@main
class AppDelegate: UIResponder, UIApplicationDelegate {

    public let signInConfig = GIDConfiguration(clientID: "547955988940-k7qo5pvcsoltfab82ujuj2h0v91ul30b.apps.googleusercontent.com")
    
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        
        
        FirebaseApp.configure()
        
    
        
        
        GIDSignIn.sharedInstance.delegate = self
   
        //  GoogleSignIn
        if let clientID = FirebaseApp.app()?.options.clientID {
            let _ = GIDConfiguration(clientID: clientID)
        }
        
        
        

        let gIdConfiguration = GIDConfiguration(clientID: "clientID", serverClientID: "serverClientID")

        GIDSignIn.sharedInstance.configuration = gIdConfiguration
        FirebaseApp.app()?.options.clientID =  gIdConfiguration.clientID

        FirebaseApp.app()?.options.clientID = GIDSignIn.sharedInstance.configuration?.clientID

        
        
        
        
        return true
    }
    
    
    
    
    
    open func application(_ app: UIApplication, open url: URL, options: [UIApplication.OpenURLOptionsKey : Any] = [:]) -> Bool {
        
        return GIDSignIn.sharedInstance.handle(url)
    }


    
    

}

