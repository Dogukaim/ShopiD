//
//  CategoryCell.swift
//  ShopiD
//
//  Created by Dogukaim on 24.09.2023.
//

import UIKit


protocol CategorysProtocolCell {
    var catproimage: String { get }
    var catproduname: String { get }
    var catproduprice: String { get }
    var catprodusold: String { get }
    var catprodurati: String { get }
}

class CategoryCell: UICollectionViewCell {

    override func awakeFromNib() {
        super.awakeFromNib()
        layer.cornerRadius = 18
        catimeP.layer.cornerRadius = 10
    }
    
    @IBOutlet weak var catProİmage: UIImageView!
    
    @IBOutlet weak var titleProduc: UILabel!
    
    @IBOutlet weak var soldLabelCat: UILabel!
    
    @IBOutlet weak var catimeP: UIImageView!
    
    @IBOutlet weak var ratingsCatPr: UILabel!
    
    @IBOutlet weak var priceLabCat: UILabel!
    
    
    func configure(data: CategorysProtocolCell) {
        catProİmage.downloadSetImage(url: data.catproimage)
        titleProduc.text = data.catproduname
        priceLabCat.text = data.catproduprice
        soldLabelCat.text = data.catprodusold
        ratingsCatPr.text = data.catprodurati
    }
    
    
    
    
}
