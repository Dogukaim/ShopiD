//
//  CollectionViewCell.swift
//  ShopiD
//
//  Created by Dogukaim on 1.09.2023.
//

import UIKit

class OnboardingViewCell: UICollectionViewCell {
    
    static let identifier = "OnboardingCell"

    @IBOutlet weak var slideImage: UIImageView!
    
    @IBOutlet weak var titleLabe: UILabel!
    
    @IBOutlet weak var subTitleL: UILabel!
    
    
    func configure(data: OnboardingSlide){
        subTitleL.text = data.subTitle
        slideImage.image = data.image
        titleLabe.text = data.title
    }
    
}
