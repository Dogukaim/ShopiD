//
//  FavoriteController.swift
//  ShopiD
//
//  Created by Dogukaim on 6.09.2023.
//

import UIKit



protocol FavoriteCollectionDelegate: AnyObject {
    func didUpdateFavoriteCollection()
    func hideFavoriteBadge()
}


class FavoriteController: UIViewController {
    
    @IBOutlet weak var favoriteCollection: UICollectionView!
    
    
    deinit {
        print("deinit FavlistController")
    }
    
    
    private let favoriteVM = FavoriteVM()
    
    //    private let productsVM = HomeViewModel()
    
    
    weak var favoriteDelegate: FavoriteCollectionDelegate?
    
    
    var homeController: HomeController?
    
    var favoriteBadgeCount: Int = 0 {
        didSet {
            // FavoriController'da kullanılacak badge güncellendiğinde yapılacak işlemler
            // Örneğin:
            if let tabBarController = self.tabBarController {
                let favoriteTabBarItem = tabBarController.tabBar.items?[1] // 1, FavoriController'ın sırasına bağlı olarak değişebilir
                favoriteTabBarItem?.badgeValue = favoriteBadgeCount > 0 ? "\(favoriteBadgeCount)" : nil
            }
        }
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        collectionSetup()
        favoriteVM.fetchFavList()
        setupDelegate()
        hideFavoriteBadge()
        
        // homeController'ı favori listesi ekranına geçerken parametre olarak alın
        if let homeController = homeController {
            homeController.homeControllerDelegate = self
            homeController.updateTabBarBadge()
        }
        
    }
    
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        print("View will appear in FavoriteController.")
        favoriteVM.fetchFavList()
        hideFavoriteBadge()
        favoriteCollection.reloadData()
        
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
    
    
    func hideFavoriteBadge() {
        // FavoriteController'daki badge'i kapatmak için gerekli işlemleri gerçekleştirin
        if let tabBarController = self.tabBarController {
            let favoriteTabIndex = 1  // Favorite tab'ının sıra numarasını belirtin
            let favoriteTabBarItem = tabBarController.tabBar.items?[favoriteTabIndex]
            favoriteTabBarItem?.badgeValue = nil
        }
    }
    
}



extension FavoriteController: UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return favoriteVM.favListProducts.count
    }
    
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        
        guard let productId = favoriteVM.favListProducts[indexPath.item].id else { return }
        
        
        guard let detailController = storyboard?.instantiateViewController(withIdentifier: "DetailController") as? DetailController else {
            print("Error: Couldn't instantiate DetailController from storyboard.")
            return
        }
        
        
        detailController.productID = productId
        
        
        navigationController?.pushViewController(detailController, animated: true)
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
        
        
    }
    
    func didFetchQuantity() {
        
    }
    
    func didFetchProductsFromFavListSuccessful() {
        self.favoriteCollection.reloadData()
        
        
    }
    
    func didFetchSingleProduct(_ product: Product) {
        
        
        
    }
    
    
    
}




extension FavoriteController: SeeAllCollectionCellInterface {
    func seeAllCollectionCell(_ view: SeeAllCollectionCell, productId: Int, quantity: Int, favButtonTapp button: UIButton) {
        
        
        let indexPath = favoriteVM.getProductIndexPath(productId: productId)
        favoriteVM.removeProduct(index: indexPath.item)
        favoriteCollection.deleteItems(at: [indexPath])
        favoriteVM.updateFavList(productId: productId, quantity: 0)
        hideHomeBadge()
    }
    
    
    func didUpdateFavoriteCollection() {
        
        favoriteCollection.reloadData()
        favoriteBadgeCount = 0
        favoriteDelegate?.didUpdateFavoriteCollection()
        print("Favorite collection updated.")
    }
    
    
    
    
}


extension FavoriteController: HomeControllerDelegate {
    
    
    
    func didUpdateHomeBadge() {
        // HomeController'daki badge'i kapatmak için gerekli işlemleri burada gerçekleştirin
        if let tabBarController = self.tabBarController {
            let homeTabIndex = 2  // Home tab'ının sıra numarasını belirtin
            let homeTabBarItem = tabBarController.tabBar.items?[homeTabIndex]
            homeTabBarItem?.badgeValue = nil
        }
    }
    
    func didUpdateFavoriteCollectionAndShowBadge() {
        if let tabBarController = self.tabBarController {
            let homeTabIndex = 2
            let homeTabBarItem = tabBarController.tabBar.items?[homeTabIndex]
            
            if !favoriteVM.favListProducts.isEmpty {
                homeTabBarItem?.badgeValue = "\(favoriteVM.favListProducts.count)"
            } else {
                homeTabBarItem?.badgeValue = "1"
            }
        }
    }
    
    
    
    
    func didUpdateFavoriteCollection(products: [Product]) {
        
    }
    
    func hideHomeBadge() {
        if let homeTabIndex = self.tabBarController?.selectedIndex {
            let homeTabBarItem = tabBarController?.tabBar.items?[homeTabIndex]
            homeTabBarItem?.badgeValue = nil
            
        }
    }
    
    
    
}



