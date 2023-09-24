//
//  ProductsCollectionCell.swift
//  ShopiD
//
//  Created by Dogukaim on 24.09.2023.
//

import UIKit


protocol ProductsProtocolCell {
    var produimage: String { get }
    var produname: String { get }
    var produprice: String { get }
    var produsold: String { get }
    var produrati: String { get }
}




class ProductsCollectionCell: UICollectionViewCell {

    override func awakeFromNib() {
        super.awakeFromNib()
        layer.cornerRadius = 24
        contImage.layer.cornerRadius = 10
        
    }

    
    @IBOutlet weak var imageProCol: UIImageView!
    @IBOutlet weak var labelProCol: UILabel!
    @IBOutlet weak var soldLabelProCol: UILabel!
    @IBOutlet weak var ratingLabelProCol: UILabel!
    @IBOutlet weak var priceLabelProCol: UILabel!
    
    @IBOutlet weak var contImage: UIImageView!
    
    func configure(data: ProductsProtocolCell) {
        imageProCol.downloadSetImage(url: data.produimage)
        labelProCol.text = data.produname
        priceLabelProCol.text = data.produprice
        soldLabelProCol.text = data.produsold
        ratingLabelProCol.text = data.produrati
    }
    
}
