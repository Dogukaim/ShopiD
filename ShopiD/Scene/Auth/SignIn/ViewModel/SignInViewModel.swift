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
import AuthenticationServices



final class SignInViewModel {

    private let googleSignInManager = GIDSignIn.sharedInstance
    private let firebaseAuth = Auth.auth()

    var credentialHandler: ((AuthCredential?, Error?) -> Void)?

    func getGoogleCredential(_ controller: UIViewController) {
        googleSignInManager.signIn(withPresenting: controller) { [weak self] user, error in
            if let error = error {
                self?.credentialHandler?(nil, error)
                return
            }

            guard let user = user else { return }
            if let authentication = user.authentication {
                let credential = GoogleAuthProvider.credential(withIDToken: authentication.idToken, accessToken: authentication.accessToken)
                self?.signInWithCredential(credential)
            }
        }
    }

    private func signInWithCredential(_ credential: AuthCredential) {
        firebaseAuth().signIn(with: credential) { [weak self] authResult, error in
            if let error = error {
                self?.credentialHandler?(nil, error)
                return
            }

            self?.credentialHandler?(credential, nil)
        }
    }
}

