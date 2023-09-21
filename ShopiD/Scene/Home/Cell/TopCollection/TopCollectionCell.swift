//
//  TopCollectionCell.swift
//  ShopiD
//
//  Created by Dogukaim on 8.09.2023.
//

import UIKit


protocol TopProtocolViewCell {
    var topimage: String { get }
    var topname: String { get }
    var topPrice: String { get }
}




class TopCollectionCell: UICollectionViewCell {

    
    @IBOutlet weak var imageTop: UIImageView!
    @IBOutlet weak var nameTop: UILabel!
    @IBOutlet weak var priceTop: UILabel!
    
    
    
    func configure(data: TopProtocolViewCell) {
        imageTop.downloadSetImage(url: data.topimage)
        nameTop.text = data.topname
        priceTop.text = data.topPrice
    }
    
    
    override func awakeFromNib() {
        
        super.awakeFromNib()
        imageTop.layer.cornerRadius = 10
        
    }
    
}


