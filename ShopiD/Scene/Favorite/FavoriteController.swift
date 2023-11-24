//
//  FavoriteController.swift
//  ShopiD
//
//  Created by Dogukaim on 6.09.2023.
//

import UIKit
import Firebase
import FirebaseFirestoreSwift
import FirebaseAuth


class FavoriteController: UIViewController {

    @IBOutlet weak var favoriteCollection: UICollectionView!
    
    
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        collectionSetup()
        
    }
    
    private func collectionSetup() {
        favoriteCollection.register(UINib(nibName: "\(FavoriteCell.self)", bundle: nil), forCellWithReuseIdentifier: "\(FavoriteCell.self)")
    }
    
    
    private func getData() {
        
    }
    
    
    
    
}
