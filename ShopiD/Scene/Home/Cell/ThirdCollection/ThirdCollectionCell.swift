//
//  ThirdCollectionCell.swift
//  ShopiD
//
//  Created by Dogukaim on 8.09.2023.
//

import UIKit

protocol ThirdProtocolViewCell {
    var thirdimage: String { get }
    var thirdname: String { get }
    var thirdprice: String { get }
}



class ThirdCollectionCell: UICollectionViewCell {

    

    @IBOutlet weak var thirdImage: UIImageView!
    @IBOutlet weak var thirdName: UILabel!
    @IBOutlet weak var thirdPrice: UILabel!
    
    
    func configure(data: ThirdProtocolViewCell) {
        thirdImage.downloadSetImage(url: data.thirdimage)
        thirdName.text = data.thirdname
        thirdPrice.text = data.thirdprice
    }
    
    
    override func awakeFromNib() {
        
        super.awakeFromNib()
        thirdImage.layer.cornerRadius = 20
        
    }
    
}
