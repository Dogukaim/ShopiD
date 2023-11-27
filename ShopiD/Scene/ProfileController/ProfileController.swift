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
    @IBOutlet weak var uploadProfileBut: UIButton!
    @IBOutlet weak var signOutBut: UIButton!
    
    
    private let profileViewModel = ProfileVM()
    override func viewDidLoad() {
        super.viewDidLoad()
        setupDelegate()
        activityIndicatorPro.isHidden = true
        profileImageActivtyIndicator.isHidden = true
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        profileViewModel.fetchUser()
        profileViewModel.fetchProfilePhoto()
        
    }
 
    
    private func setupDelegate() {
        profileViewModel.delegate = self
        uploadProfileBut.layer.cornerRadius = 28
        uploadProfileBut.layer.masksToBounds = true

        signOutBut.layer.cornerRadius = 35
        signOutBut.layer.masksToBounds = true
        
        profileImage.layer.cornerRadius = profileImage.frame.width / 2
        profileImage.layer.masksToBounds = true
    }
    
    
    @IBAction func addProfileButTap(_ sender: UIButton) {
        
        activityIndicatorPro.isHidden = false
        activityIndicatorPro.startAnimating()
        profileImageActivtyIndicator.isHidden = true
        profileImageActivtyIndicator.startAnimating()
        
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
        print("Upload successful, hiding profileImageActivtyIndicator")
        profileViewModel.fetchProfilePhoto()
        profileImageActivtyIndicator.stopAnimating()
         profileImageActivtyIndicator.isHidden = true
        activityIndicatorPro.stopAnimating()
            
    }
    
    func didFetchProfilePhotoSuccessful(_ url: String) {
        profileImage.downloadSetImage(url: url)
        profileImageActivtyIndicator.stopAnimating()
        
    }
    
    
}


extension ProfileController: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {

        
        
        activityIndicatorPro.stopAnimating()
        activityIndicatorPro.isHidden = true
        picker.dismiss(animated: true)
        
        guard let image = info[.editedImage] as? UIImage else { return }
        guard let imageData = image.pngData() else { return }
        
        profileViewModel.uploadImageDataToFirebaseStorage(imageData)
        profileImageActivtyIndicator.startAnimating()
        profileImageActivtyIndicator.isHidden = true
        profileImage.image = image
        


    }
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        activityIndicatorPro.stopAnimating()
        activityIndicatorPro.isHidden = true
        
        profileImageActivtyIndicator.stopAnimating()
        profileImageActivtyIndicator.isHidden = true
        picker.dismiss(animated: true)
    }
}









