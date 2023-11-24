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
    var productId: Int { get }
}


protocol FavoriteProductCollectionCellInterface: AnyObject {
    func favoriteCell(_ view: FavoriteCell,productId: Int,quantity: Int,favButtonTapped button: UIButton)
}



class FavoriteCell: UICollectionViewCell {

    @IBOutlet weak var containerFavView: UIView!
    @IBOutlet weak var productFavImage: UIImageView!
    @IBOutlet weak var favProductName: UILabel!
    @IBOutlet weak var productFavPrice: UILabel!
    @IBOutlet weak var favButtton: UIButton!
    
    
    weak var interface: FavoriteProductCollectionCellInterface?
    var productId: Int?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        containerFavView.layer.cornerRadius = 26
        
    }
    
    
    func configure(data: FavProtocolViewCell) {
        productFavImage.downloadSetImage(url: data.favProİmage)
        favProductName.text = data.favProName
        productFavPrice.text = data.favProPrice
        productId = data.productId
        
    }
    
    
    
    @IBAction func addToFavoriteButTapp(_ button: UIButton) {
        
        
        guard let productId = productId else { return }
        if favButtton.isSelected == false {
            interface?.favoriteCell(self, productId: productId, quantity: 1, favButtonTapped: button)
        } else {
            interface?.favoriteCell(self, productId: productId, quantity: 0, favButtonTapped: button)
        }
        
        favButtton.isSelected.toggle()
        
    }
    
    func toggleAddButton() {
        let image = UIImage(systemName: "heart")
        let imageFilled = UIImage(systemName: "heart.fill")
        favButtton.setImage(image, for: .normal)
        favButtton.setImage(imageFilled, for: .selected)
    }
}
