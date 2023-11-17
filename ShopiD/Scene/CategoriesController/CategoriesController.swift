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
    
    private let productsviewModel = HomeViewModel()
    private let searchVM = SearchViewModel()
    
    private let cellSpacing: CGFloat = 10
    
    override func viewDidLoad() {
        super.viewDidLoad()

        collectionSetup()
        isSucced()
        searchDelegate()
        getData()

    }
    
    func isSucced() {
        productsviewModel.successCallback = { [weak self] in
            self?.catCollectionn.reloadData()
            

        }
    }
    
    
    
    private func getData() {
        productsviewModel.fetchAllProducts()
        searchVM.filterContentForSearchText(nil)
//        catCollectionn.reloadData()
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

//            return CGSize(width: ((catCollectionn.frame.width / 2)), height: (catCollectionn.frame.height / 2))
            
            
            let collectionViewWidth = collectionView.frame.width
            let itemWidth = (collectionViewWidth - 3 * cellSpacing) / 2
            
            return CGSize(width: itemWidth, height: itemWidth)

        }
        
        else {
            
            return collectionView.contentSize
        }
        
    }
    
    
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        let selectedPro = productsviewModel.seeAllProducts[indexPath.item].id
        let controller = self.storyboard?.instantiateViewController(withIdentifier: "DetailController") as! DetailController
        controller.productID = selectedPro
        
        self.navigationController?.pushViewController(controller, animated: true)
        
        
    }
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
           // Arama butonuna basıldığında klavyeyi kapat
        searchBar.resignFirstResponder()
       }
    
    // Ekranın başka bir yerine tıklandığında klavyeyi kapat
        override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
            if let touch = touches.first {
                let touchPoint = touch.location(in: view)

                // Eğer dokunulan nokta, searchBarCate'ın dışında ise klavyeyi kapat
                if !searchbarCate.frame.contains(touchPoint) {
                    searchbarCate.resignFirstResponder()
                }
            }
        }
    
    
    
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
            // ViewModel'de arama işlemini gerçekleştir
            searchVM.filterContentForSearchText(searchText)

            // UICollectionView'ı güncelle
            catCollectionn.reloadData()
        }
    
    
    
    
    
}





