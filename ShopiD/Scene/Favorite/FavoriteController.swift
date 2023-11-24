//
//  FavoriteController.swift
//  ShopiD
//
//  Created by Dogukaim on 6.09.2023.
//

import UIKit



protocol FavoriteCollectionDelegate: AnyObject {
    func didUpdateFavoriteCollection()
}


class FavoriteController: UIViewController {

    @IBOutlet weak var favoriteCollection: UICollectionView!
    
    
    deinit {
        print("deinit FavlistController")
    }
    
    
    private let favoriteVM = FavoriteVM()
    
    private let productsVM = HomeViewModel()
    
    var favoriteDelegate: FavoriteCollectionDelegate?
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        collectionSetup()
        getData()
        setupDelegate()
    }
    
    private func collectionSetup() {
        favoriteCollection.register(UINib(nibName: "\(FavoriteCell.self)", bundle: nil), forCellWithReuseIdentifier: "\(FavoriteCell.self)")
    }
    
    
    private func getData() {
        favoriteVM.fetchFavList()
    }
    
    
    private func setupDelegate() {
        favoriteVM.delegate = self
        
        
        
        
    }
    
    
    func updateFavoriteCollection(products: [Product]) {
           favoriteVM.favListProducts = products
           favoriteCollection.reloadData()
       }
    
}



extension FavoriteController: UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return favoriteVM.favListProducts.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
//        guard let cell = favoriteCollection.dequeueReusableCell(withReuseIdentifier: "\(FavoriteCell.self)", for: indexPath) as? FavoriteCell else { return UICollectionViewCell() }
//        cell.
//        cell.configure(data: favoriteVM.favListProducts[indexPath.item])
        
        guard let cell = favoriteCollection.dequeueReusableCell(withReuseIdentifier: "\(FavoriteCell.self)", for: indexPath) as? FavoriteCell else { return UICollectionViewCell() }
        cell.interface = self
        cell.favButtton.isSelected = true
        cell.configure(data: favoriteVM.favListProducts[indexPath.item])
        
        return cell
        
        
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: favoriteCollection.frame.width / 2 - 10, height: favoriteCollection.frame.width / 2)
    }
    
    
    
}

extension FavoriteController: SeeAllCollectionCellInterface {
    func seeAllCollectionCell(_ view: SeeAllCollectionCell, productId: Int, quantity: Int, favButtonTapp button: UIButton) {
        let indexPath = favoriteVM.getProductIndexPath(productId: productId)
        favoriteVM.removeProduct(index: indexPath.item)
        favoriteCollection.deleteItems(at: [indexPath])
        favoriteVM.updateFavList(productId: productId, quantity: 0)
    }
    
    
}



extension FavoriteController: FavoriteProductCollectionCellInterface {
    func favoriteCell(_ view: FavoriteCell, productId: Int, quantity: Int, favButtonTapped button: UIButton) {
        let indexPath = favoriteVM.getProductIndexPath(productId: productId)
        favoriteVM.removeProduct(index: indexPath.item)
        favoriteCollection.deleteItems(at: [indexPath])
        favoriteVM.updateFavList(productId: productId, quantity: 0)
    }
    
    
}


extension FavoriteController: FavoriteVMDelegate {
    func didOccurError(_ error: Error) {
        print(error.localizedDescription)
    }
    
    func didUpdatedFavlisSuccessful() {
        favoriteVM.fetchFavList()
    }
    
    func didFetchQuantity() {
        
    }
    
    func didFetchProductsFromFavListSuccessful() {
        DispatchQueue.main.async {
                  self.favoriteCollection.reloadData()
            self.favoriteDelegate?.didUpdateFavoriteCollection()
              }
    }
    
    func didFetchSingleProduct(_ product: Product) {
//        <#code#>
    }
    
    
}
