//
//  ProductController.swift
//  ShopiD
//
//  Created by Dogukaim on 7.09.2023.
//

import UIKit

class ProductController: UIViewController {

    @IBOutlet weak var productsColl: UICollectionView!
    
    
    var details: [Product] = []
    
    private let productsviewModel = HomeViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        collectionSetup()
        getData()
        isSucced()
    }
    

    private func collectionSetup() {
        productsColl.register(UINib(nibName: "\(ProductsCollectionCell.self)", bundle: nil), forCellWithReuseIdentifier: "\(ProductsCollectionCell.self)")
    }
    
    
    func getData() {
        productsviewModel.fetchAllProducts()
        
    }
    
    func isSucced() {
        productsviewModel.successCallback = { [weak self] in
            self?.productsColl.reloadData()
        }
    }
    
    

    
}





extension ProductController: UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        switch collectionView {
        case productsColl:
            return productsviewModel.seeAllProducts.count
        
        default:
            return 0
        }

    }
        
        
    
        
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
    switch collectionView {
        case productsColl:
        guard let cell = productsColl.dequeueReusableCell(withReuseIdentifier: "\(ProductsCollectionCell.self)", for: indexPath) as? ProductsCollectionCell else { return UICollectionViewCell() }
        cell.configure(data: productsviewModel.seeAllProducts[indexPath.item])
        return cell
    default:
        return UICollectionViewCell()
        }
    }
    
    
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        
        if  (productsColl == collectionView )  {

            return CGSize(width: ((productsColl.frame.width / 2.5) + 26), height: (productsColl.frame.height / 2))

        }
        
        else {
            
            return collectionView.contentSize
        }
        
    }
    
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
//        let controller = self.storyboard?.instantiateViewController(withIdentifier: "DetailController") as!  DetailController
//        self.navigationController?.pushViewController(controller, animated: true)
//        let prodcut = products[indexPath.row]
//        
//        performSegue(withIdentifier: DetailController.detailSegue, sender: prodcut)
//        collectionView.deselectItem(at: indexPath, animated: true)
//        
//        let selectedDetail = details[indexPath.row]
        
        
        
        
        
    }
    
//    func showDetailViewCont(with productD: Product) {
//        let productDetailVC = DetailController(product: productD)
//        self.navigationController?.pushViewController(productDetailVC, animated: true)
//    }
//    
}
