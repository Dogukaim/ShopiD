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
}



class SeeAllCollectionCell: UICollectionViewCell {

    
    
    @IBOutlet weak var proImageView: UIImageView!
    @IBOutlet weak var proTitle: UILabel!
    @IBOutlet weak var proPrice: UILabel!
    
    
    func configure(data: SeeProtocolViewCell) {
        proImageView.downloadSetImage(url: data.proimage)
        proTitle.text = data.proname
        proPrice.text = data.proprice
    }
    
    override func awakeFromNib() {
        
        super.awakeFromNib()
        layer.cornerRadius = 12

        
    }
    

}
