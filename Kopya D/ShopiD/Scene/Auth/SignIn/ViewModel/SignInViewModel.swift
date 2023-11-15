//
//  SignInViewModel.swift
//  ShopiD
//
//  Created by Dogukaim on 6.09.2023.
//

import GoogleSignIn
import FirebaseCore
import FirebaseAuth
import FirebaseDatabase
import FirebaseFirestore


final class SignInViewModel {
    
    
    //MARK: - Google SignIn Manager
    private let googleSignInManager = GIDSignIn.sharedInstance
    
    private let errorr = LocalizedError.self
    
    private let credential = AuthCredential.self
    
    
    //MARK: - FirestoreDatabase Constants
    private let database = Firestore.firestore()
    private let firebaseAuth = Auth.auth()
    
    
    
}
    
    
    //MARK: - SignInWithGoogle Methods

//    extension SignInViewModel {
//        
//        func getGoogleCredential(_ controller: UIViewController) {
//            googleSignInManager.signIn(withPresenting: controller) { [weak self] userResult, error in
//                
//                if let error = error {
//                    self?.credential.onError(error)
//                    return
//                }
//                
//                guard let userResult = userResult else { return }
//                if let idToken = userResult.user.idToken?.tokenString {
//                    let accessToken = userResult.user.accessToken.tokenString
//                    let credential = GoogleAuthProvider.credential(withIDToken: idToken, accessToken: accessToken)
//                    self?.credential.onNext(credential)
//                }
//                
//            }
//        }
//    }



