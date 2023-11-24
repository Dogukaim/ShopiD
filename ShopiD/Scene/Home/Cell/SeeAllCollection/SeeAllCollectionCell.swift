//
//  SeeAllCollectionCell.swift
//  ShopiD
//
//  Created by Dogukaim on 8.09.2023.
//

import UIKit


protocol SeeProtocolViewCell {
    var proimage: String { get }
    var proname: String { get }
    var proprice: String { get }
    var proId: Int { get }
}






protocol SeeAllCollectionCellInterface: AnyObject {
    func seeAllCollectionCell(_ view: SeeAllCollectionCell,productId: Int,quantity: Int, favButtonTapp button: UIButton)
}




class SeeAllCollectionCell: UICollectionViewCell {

    
    
    @IBOutlet weak var proImageView: UIImageView!
    @IBOutlet weak var proTitle: UILabel!
    @IBOutlet weak var proPrice: UILabel!
    @IBOutlet weak var addFavButton: UIButton!
    
    
    
    
    

    
    weak var interface: SeeAllCollectionCellInterface?
    
    private var productId: Int?
    
    
    
    
    
    
    
    func configure(data: SeeProtocolViewCell) {
        proImageView.downloadSetImage(url: data.proimage)
        proTitle.text = data.proname
        proPrice.text = data.proprice
        productId = data.proId
    }
    
    override func awakeFromNib() {
        
        super.awakeFromNib()
        layer.cornerRadius = 12

        toggleAddButton()
    }
    @IBAction func favButtonTapp(_ button: UIButton) {
        
        guard let productId = productId else { return }
        if addFavButton.isSelected == false {
            interface?.seeAllCollectionCell(self, productId: productId, quantity: 1, favButtonTapp: button)
        } else {
            interface?.seeAllCollectionCell(self, productId: productId, quantity: 0, favButtonTapp: button)
        }
        
        addFavButton.isSelected.toggle()
    }
    
    
    
    func toggleAddButton() {
        let image = UIImage(systemName: "heart")
        let imageFilled = UIImage(systemName: "heart.fill")
        addFavButton.setImage(image, for: .normal)
        addFavButton.setImage(imageFilled, for: .selected)
    }
    
    
    
    
    
}
