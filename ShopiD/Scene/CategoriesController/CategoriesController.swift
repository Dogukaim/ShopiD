//
//  CategoriesController.swift
//  ShopiD
//
//  Created by Dogukaim on 7.09.2023.
//

import UIKit

class CategoriesController: UIViewController, UISearchBarDelegate {
    
    

    
    @IBOutlet weak var catCollectionn: UICollectionView!
    
    @IBOutlet weak var searchbarCate: UISearchBar!
    
    private let productsviewModel = ProductsViewModel()

    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        collectionSetup()
        isSucced()
        
        getData()
        
//        navigationController?.hidesBarsOnSwipe = true
    }
    
    func isSucced() {
        productsviewModel.successCallback = { [weak self] in
            self?.catCollectionn.reloadData()
            

        }
    }
    
    
    
    private func getData() {
        productsviewModel.fetchAllProducts()
        
    }
    
    
    private func collectionSetup() {
        
        catCollectionn.register(UINib(nibName: "\(CategoryCell.self)", bundle: nil), forCellWithReuseIdentifier: "\(CategoryCell.self)")
        
        
        
    }
    
    private func searchDelegate() {
        
        searchbarCate.delegate = self
    }
    
    
}



extension CategoriesController: UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        switch collectionView {
        case catCollectionn:
            return productsviewModel.seeAllProducts.count
            
        default:
            return 0
        }
        
    }
    
    
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
    switch collectionView {
        case catCollectionn:
        guard let cell = catCollectionn.dequeueReusableCell(withReuseIdentifier: "\(CategoryCell.self)", for: indexPath) as? CategoryCell else { return UICollectionViewCell() }
        cell.configure(data: productsviewModel.seeAllProducts[indexPath.row])
        
        return cell
    default:
        return UICollectionViewCell()
        }
    }
    
    
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        
        if  (catCollectionn == collectionView )  {

            return CGSize(width: ((catCollectionn.frame.width / 2.5) + 26), height: (catCollectionn.frame.height / 2))

        }
        
        else {
            
            return collectionView.contentSize
        }
        
    }
    
    
    
    
    
}


//extension CategoriesController: UIScrollViewDelegate{
//    
//    func scrollViewWillBeginDragging(_ scrollView: UIScrollView) {
//        self.navigationController!.setNavigationBarHidden(true, animated: true)
//    }
//    
//    func scrollViewDidEndDragging(_ scrollView: UIScrollView, willDecelerate decelerate: Bool) {
//        self.navigationController!.setNavigationBarHidden(false, animated: true)
//    }
//}
