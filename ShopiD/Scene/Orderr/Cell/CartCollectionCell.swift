//
//  CartCollectionCell.swift
//  ShopiD
//
//  Created by Dogukaim on 10.12.2023.
//

import UIKit



protocol CartProtocolViewCell {
    var orderİmage: String { get }
    var orderName: String { get }
    var orderPrice: String { get }
    var orderCategoryLbl: String { get }
}


class CartCollectionCell: UICollectionViewCell {

    @IBOutlet weak var imageOrder: UIImageView!
    @IBOutlet weak var cartName: UILabel!
    @IBOutlet weak var cartCategoryLabel: UILabel!
    @IBOutlet weak var cartPriceLabel: UILabel!
    @IBOutlet weak var plusCart: UIButton!
    @IBOutlet weak var minusCart: UIButton!
    
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        plusCart.layer.cornerRadius = 15
        minusCart.layer.cornerRadius = 15
    }
    
    func configure(data: CartProtocolViewCell) {
        imageOrder.downloadSetImage(url: data.orderİmage)
        cartName.text = data.orderName
        cartCategoryLabel.text = data.orderCategoryLbl
        cartPriceLabel.text = data.orderPrice
        
        
    }
    
    
    
    
    
}
