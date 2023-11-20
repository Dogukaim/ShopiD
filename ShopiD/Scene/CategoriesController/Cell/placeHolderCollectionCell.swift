//
//  placeHolderCollectionCell.swift
//  ShopiD
//
//  Created by Dogukaim on 20.11.2023.
//

import UIKit

class placeHolderCollectionCell: UICollectionViewCell {

    @IBOutlet weak var placeholderCell: UIImageView!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        layer.cornerRadius = 18
        placeholderCell.layer.cornerRadius = 10
        configure()
    }
    
    
    func configure() {
        placeholderCell.image = UIImage(named: "placeholder1")
    }
    
    
    
}
