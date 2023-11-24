//
//  FavoriteCell.swift
//  ShopiD
//
//  Created by Dogukaim on 23.11.2023.
//

import UIKit



protocol FavProtocolViewCell {
    var favProİmage: String { get }
    var favProName: String { get }
    var favProPrice: String { get }
}



class FavoriteCell: UICollectionViewCell {

    @IBOutlet weak var containerFavView: UIView!
    @IBOutlet weak var productFavImage: UIImageView!
    @IBOutlet weak var favProductName: UILabel!
    @IBOutlet weak var productFavPrice: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        containerFavView.layer.cornerRadius = 26
        
    }
    
    
    func configure(data: FavProtocolViewCell) {
        productFavImage.downloadSetImage(url: data.favProİmage)
        favProductName.text = data.favProName
        productFavPrice.text = data.favProPrice
        
    }
    

}
