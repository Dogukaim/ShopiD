//
//  SignInViewModel.swift
//  ShopiD
//
//  Created by Dogukaim on 6.09.2023.
//
//
import GoogleSignIn
import FirebaseAuth
import GoogleSignInSwift

final class SignInViewModel {
//
//    private let googleSignInManager = GIDSignIn.sharedInstance
//    private let firebaseAuth = Auth.auth()
//
//    var credentialHandler: ((AuthCredential?, Error?) -> Void)?
//
//    func getGoogleCredential(viewController: UIViewController) {
//        // GIDConfiguration'ı oluştur ve gerekli ayarlamaları yap
//        let config = GIDConfiguration(clientID: "547955988940-k7qo5pvcsoltfab82ujuj2h0v91ul30b.apps.googleusercontent.com")
//
//        // Google SignIn işlemini başlat
//        googleSignInManager.signIn(with: config, presenting: viewController) { [weak self] user, error in
//            if let error = error {
//                self?.credentialHandler?(nil, error)
//                return
//            }
//
//            guard let user = user else {
//                // Kullanıcı bilgisi alınamazsa işlemleri burada ele alabilirsiniz
//                return
//            }
//
//            if let authentication = user.authentication {
//                let credential = GoogleAuthProvider.credential(withIDToken: authentication.idToken, accessToken: authentication.accessToken)
//                self?.signIn(with: credential)
//            }
//        }
//    }
//
//    private func signIn(with credential: AuthCredential) {
//        firebaseAuth.signIn(with: credential) { [weak self] authResult, error in
//            if let error = error {
//                self?.credentialHandler?(nil, error)
//                return
//            }
//
//            self?.credentialHandler?(credential, nil)
//        }
//    }
}






