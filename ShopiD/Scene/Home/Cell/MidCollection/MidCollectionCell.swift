//
//  MidCollectionCell.swift
//  ShopiD
//
//  Created by Dogukaim on 8.09.2023.
//

import UIKit



class MidCollectionCell: UICollectionViewCell {

    
    @IBOutlet weak var categorysLabel: UILabel!
    
    
    
    
    func configure(data: Categories, indexPath: IndexPath) {
        categorysLabel.text = data[indexPath.row].capitalized
    }

}
