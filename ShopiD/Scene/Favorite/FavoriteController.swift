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
    
    //    private let productsVM = HomeViewModel()
    
    
    var favoriteDelegate: FavoriteCollectionDelegate?
    
    
    
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        collectionSetup()
        
        
        
        favoriteVM.fetchFavList()
        setupDelegate()
    }
    
    private func collectionSetup() {
        favoriteCollection.register(UINib(nibName: "\(SeeAllCollectionCell.self)", bundle: nil), forCellWithReuseIdentifier: "\(SeeAllCollectionCell.self)")
    }
    
    
    
    
    private func setupDelegate() {
        favoriteVM.delegate = self
        
        
    }
    
    
    func updateFavoriteCollection(products: [Product]) {
        if !products.isEmpty {
            favoriteVM.favListProducts = products
            favoriteCollection.reloadData()
        }
    }
    
    
}



extension FavoriteController: UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return favoriteVM.favListProducts.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = favoriteCollection.dequeueReusableCell(withReuseIdentifier: "\(SeeAllCollectionCell.self)", for: indexPath) as? SeeAllCollectionCell else { return UICollectionViewCell() }
        cell.interface = self
        cell.addFavButton.isSelected = true
        cell.configure(data: favoriteVM.favListProducts[indexPath.item])
        
        return cell
        
        
        
        
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let spacing: CGFloat = 10
        let itemWidth = (collectionView.frame.width - 3 * spacing) / 2
        let itemHeight: CGFloat = 177 // İsterseniz farklı bir yükseklik de belirleyebilirsiniz
        
        return CGSize(width: itemWidth, height: itemHeight)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
           return 10 // Yatay boşluk (hücreler arasındaki boşluk)
       }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
           return 10 // Dikey boşluk (satırlar arasındaki boşluk)
       }
    
}



extension FavoriteController: FavoriteVMDelegate {
    
    
    func didOccurError(_ error: Error) {
        print(error.localizedDescription)
    }
    
    func didUpdatedFavlisSuccessful() {
        
        //        favoriteVM.fetchFavList()
    }
    
    func didFetchQuantity() {
        
    }
    
    func didFetchProductsFromFavListSuccessful() {
        self.favoriteCollection.reloadData()
    }
    
    func didFetchSingleProduct(_ product: Product) {
        //        <#code#>
    }
    
    
    
}




extension FavoriteController: SeeAllCollectionCellInterface {
    func seeAllCollectionCell(_ view: SeeAllCollectionCell, productId: Int, quantity: Int, favButtonTapp button: UIButton) {
        
        
        let indexPath = favoriteVM.getProductIndexPath(productId: productId)
        favoriteVM.removeProduct(index: indexPath.item)
        favoriteCollection.deleteItems(at: [indexPath])
        favoriteVM.updateFavList(productId: productId, quantity: 0)
        
    }
    
    
    func didUpdateFavoriteCollection() {
            // Favori koleksiyon güncellendiğinde yapılacak işlemler burada gerçekleştirilebilir
            // Örneğin, koleksiyon görünümünü yenilemek:
            favoriteCollection.reloadData()
        
        print("Favorite collection updated.")
        }
    
}


