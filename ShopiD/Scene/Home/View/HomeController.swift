//
//  HomeController.swift
//  ShopiD
//
//  Created by Dogukaim on 6.09.2023.
//

import UIKit


protocol HomeControllerDelegate: AnyObject {
    func didUpdateFavoriteCollection(products: [Product])
    func didUpdateHomeBadge()
}



final class HomeController: UIViewController {
    
    
    
    
    @IBOutlet weak var topCollection: UICollectionView!
    @IBOutlet weak var catCollect: UICollectionView!
    @IBOutlet weak var specialCollct: UICollectionView!
    @IBOutlet weak var seeAllCollect: UICollectionView!
    
    @IBOutlet weak var searchs: UISearchBar!
    
    
    private let productsviewModel = HomeViewModel()
    
    private let searchVM = SearchViewModel()
    
    private let favoriteVM = FavoriteVM()
    
    
    private var products = [Product]()
    var details: [Product] = []
    
    var productt: Product?
    
    
    
    weak var homeControllerDelegate: HomeControllerDelegate?
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureNavBar()
        collectionSetup()
        isSucced()
        
        getData()
        
    }
    
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        
        
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        
    }
    
    
    
    func isSucced() {
        productsviewModel.successCallback = { [weak self] in
            self?.topCollection.reloadData()
            self?.catCollect.reloadData()
            self?.specialCollct.reloadData()
            self?.seeAllCollect.reloadData()
            
        }
    }
    
    
    private func getData() {
        productsviewModel.fetchAllProducts()
        productsviewModel.fetchOnlyCategory()
        productsviewModel.fetchSpecialProducts()
        
        
        
    }
    
    
    
    private func configureNavBar() {
        navigationController?.isNavigationBarHidden = false
        navigationItem.backBarButtonItem = UIBarButtonItem(title: "", style: .plain, target: nil, action: nil)
        navigationController?.navigationBar.prefersLargeTitles = false
        navigationItem.backBarButtonItem?.tintColor = .black
    }
    
    
    
    private func collectionSetup() {
        topCollection.register(UINib(nibName: "\(TopCollectionCell.self)", bundle: nil), forCellWithReuseIdentifier: "\(TopCollectionCell.self)")
        
        catCollect.register(UINib(nibName: "\(MidCollectionCell.self)", bundle: nil), forCellWithReuseIdentifier: "\(MidCollectionCell.self)")
        specialCollct.register(UINib(nibName: "\(ThirdCollectionCell.self)", bundle: nil), forCellWithReuseIdentifier: "\(ThirdCollectionCell.self)")
        
        seeAllCollect.register(UINib(nibName: "\(SeeAllCollectionCell.self)", bundle: nil), forCellWithReuseIdentifier: "\(SeeAllCollectionCell.self)")
    }
    
    
    private func searchDelegate() {
        
        searchs.delegate = self
        
        productsviewModel.delegate = self
        
        
    }
    
    
}


//MARK: - SerchBar Methods

extension HomeController: UISearchBarDelegate {
    func searchBarTextDidBeginEditing(_ searchBar: UISearchBar) {
        let controller = self.storyboard?.instantiateViewController(withIdentifier: "CategoriesController") as!  CategoriesController
        self.navigationController?.pushViewController(controller, animated: true)
        
    }
    
}

//MARK: Scrool Navigation

extension HomeController: UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout {
    
    
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        switch collectionView {
        case topCollection:
            return productsviewModel.seeAllProducts.count
            
        case catCollect:
            return productsviewModel.allCategories.count
            
        case specialCollct:
            return productsviewModel.specialProducts.count
            
        case seeAllCollect:
            return productsviewModel.seeAllProducts.count
            
        default:
            return 0
        }
    }
    
    
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        switch collectionView {
        case topCollection:
            guard let cell = topCollection.dequeueReusableCell(withReuseIdentifier: "\(TopCollectionCell.self)", for: indexPath) as? TopCollectionCell else { return UICollectionViewCell() }
            cell.configure(data: productsviewModel.seeAllProducts[indexPath.item])
            
            return cell
        case catCollect:
            guard let cell = catCollect.dequeueReusableCell(withReuseIdentifier: "\(MidCollectionCell.self)", for: indexPath) as? MidCollectionCell else { return UICollectionViewCell() }
            cell.configure(data: productsviewModel.allCategories, indexPath: indexPath)
            
            return cell
        case specialCollct:
            guard let cell = specialCollct.dequeueReusableCell(withReuseIdentifier: "\(ThirdCollectionCell.self)", for: indexPath) as? ThirdCollectionCell else { return UICollectionViewCell() }
            cell.configure(data: productsviewModel.specialProducts[indexPath.item])
            return cell
            
        case seeAllCollect:
            guard let cell = seeAllCollect.dequeueReusableCell(withReuseIdentifier: "\(SeeAllCollectionCell.self)", for: indexPath) as? SeeAllCollectionCell else { return UICollectionViewCell() }
            cell.configure(data: productsviewModel.seeAllProducts[indexPath.item])
            cell.interface = self
            
            return cell
        default:
            return UICollectionViewCell()
        }
    }
    
    
    
    
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        
        
        if (topCollection  == collectionView) {
            
            return CGSize(width: (topCollection.frame.width / 3), height: (topCollection.frame.height))
            
        }
        else if  (seeAllCollect == collectionView )  {
            
            return CGSize(width: ((seeAllCollect.frame.width / 2.5) + 26), height: (seeAllCollect.frame.height / 4))
            
        }
        else if  (specialCollct == collectionView) {
            
            return CGSize(width: (specialCollct.frame.width / 3), height: (specialCollct.frame.height))
            
        }
        
        
        else {
            
            return collectionView.contentSize
        }
    }
    
    
    
    
    
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        switch collectionView {
            
        case topCollection:
            let controller = self.storyboard?.instantiateViewController(withIdentifier: "ProductController") as!  ProductController
            self.navigationController?.pushViewController(controller, animated: true)
            
        case catCollect:
            let controller = self.storyboard?.instantiateViewController(withIdentifier: "CategoriesController") as!  CategoriesController
            self.navigationController?.pushViewController(controller, animated: true)
            
        case specialCollct:
            let controller = self.storyboard?.instantiateViewController(withIdentifier: "ProductController") as!  ProductController
            self.navigationController?.pushViewController(controller, animated: true)
            
        case seeAllCollect:
            let selectedProductID = productsviewModel.seeAllProducts[indexPath.item].id
            let controller = self.storyboard?.instantiateViewController(withIdentifier: "DetailController") as! DetailController
            controller.productID = selectedProductID
            
            self.navigationController?.pushViewController(controller, animated: true)
            
        default:
            return print("Did not show next VC")
        }
    }
    
}



extension HomeController: SeeAllCollectionCellInterface {
    func didUpdateFavoriteCollection() {
        
        
        updateTabBarBadge()
    }
    
    func seeAllCollectionCell(_ view: SeeAllCollectionCell, productId: Int, quantity: Int, favButtonTapp button: UIButton) {
        productsviewModel.updateFavoriList(productId: productId, quantity: quantity)
        homeControllerDelegate?.didUpdateFavoriteCollection(products: productsviewModel.seeAllProducts)
    }
    
    
    
    
    func updateTabBarBadge() {
        if let tabBarController = self.tabBarController {
            let favoriteTabIndex = 1
            let favoriteTabBarItem = tabBarController.tabBar.items?[favoriteTabIndex]
            
            if !favoriteVM.favListProducts.isEmpty {
                favoriteTabBarItem?.badgeValue = "\(favoriteVM.favListProducts.count)"
            } else {
                favoriteTabBarItem?.badgeValue = "1"
            }
        }
        
        homeControllerDelegate?.didUpdateHomeBadge()
    }
    
    
    
}




extension HomeController: HomeVMDelegate {
    func didFetchAllProductsSucc() {
        
    }
    
    func didOccurError(_ error: Error) {
        print(error.localizedDescription)
    }
    
    func didFetchSingleProduct(_ product: Product) {
        
    }
    
    func didFetchAllCategories() {
        
    }
    
    func didFetchSpecialProductsSuccessful() {
        specialCollct.reloadData()
    }
    
    func didUpdateFavListSuccessful() {
        
    }
    
    
    
    
    
    
}


