//
//  ProfileController.swift
//  ShopiD
//
//  Created by Dogukaim on 6.09.2023.
//

import UIKit

class ProfileController: UIViewController {

    @IBOutlet weak var profileImage: UIImageView!
    @IBOutlet weak var profileImageActivtyIndicator: UIActivityIndicatorView!
    @IBOutlet weak var userNameLabel: UILabel!
    @IBOutlet weak var activityIndicatorPro: UIActivityIndicatorView!
    @IBOutlet weak var emailLabel: UILabel!
    
    
    private let profileViewModel = ProfileVM()
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupDelegate()
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        profileViewModel.fetchUser()
        profileViewModel.fetchProfilePhoto()
    }
 
    
    private func setupDelegate() {
        profileViewModel.delegate = self
    }
    
    
    @IBAction func addProfileButTap(_ sender: UIButton) {
        activityIndicatorPro.startAnimating()
        let picker = UIImagePickerController()
        picker.sourceType = .photoLibrary
        picker.delegate = self
        picker.allowsEditing = true
        present(picker, animated: true)
    }
    
    
    @IBAction func signOutButTap(_ sender: UIButton) {
        profileViewModel.signOut()
        
    }
    
    
    
    func configure(email: String, username: String) {
        profileImage.image = UIImage(systemName: "person")
        userNameLabel.text = "\(username)"
        emailLabel.text = "\(email)"
    }
    
}


extension ProfileController: ProfileVMDelegate {
    func didOccurError(_ error: Error) {
        print(error.localizedDescription)
    }
    
    func didSignOutSuccessful() {
        let signInVC = SignInController()
        signInVC.modalPresentationStyle = .fullScreen
        present(signInVC, animated: true)
        
    }
    
    func didFetchUserInfo() {
        configure(email: profileViewModel.email ?? "not email", username: profileViewModel.username ?? "not user")
    }
    
    func didUploadProfilePhotoSuccessful() {
        profileViewModel.fetchProfilePhoto()
    }
    
    func didFetchProfilePhotoSuccessful(_ url: String) {
        profileImage.downloadSetImage(url: url)
        profileImageActivtyIndicator.stopAnimating()
    }
    
    
}


extension ProfileController: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        activityIndicatorPro.stopAnimating()
        picker.dismiss(animated: true)
        
        guard let image = info[UIImagePickerController.InfoKey.editedImage] as? UIImage else { return }
        guard let imageData = image.pngData() else { return }
        profileViewModel.uploadImageDataToFirebaseStorage(imageData)
        profileImageActivtyIndicator.startAnimating()

    }
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        picker.dismiss(animated: true)
    }
}
