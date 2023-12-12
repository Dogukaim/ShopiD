//
//  OrderViewController.swift
//  ShopiD
//
//  Created by Dogukaim on 7.09.2023.
//

import UIKit

class OrderViewController: UIViewController {

    @IBOutlet weak var cartCollection: UICollectionView!
    @IBOutlet weak var priceCartLabel: UILabel!
    
    private let cartVM  = CartViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        collectionSetup()
        
    }
    
    
    private func collectionSetup() {
        cartCollection.register(UINib(nibName: "\(CartCollectionCell.self)", bundle: nil), forCellWithReuseIdentifier: "\(CartCollectionCell.self)")
    }
    


}



extension OrderViewController: UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 2
    }
    
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        
      
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = cartCollection.dequeueReusableCell(withReuseIdentifier: "\(CartCollectionCell.self)", for: indexPath) as? CartCollectionCell else { return UICollectionViewCell() }
        
        
//        cell.configure(data: <#T##CartProtocolViewCell#>)
        
        return cell
        
        
        
        
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let spacing: CGFloat = 10
        let itemWidth = (collectionView.frame.width - 3 * spacing) / 2
        let itemHeight: CGFloat = 177
        
        return CGSize(width: itemWidth, height: itemHeight)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 10
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 10
    }
    
    
    
    
}
