//
//  HomeController.swift
//  ShopiD
//
//  Created by Dogukaim on 6.09.2023.
//

import UIKit




class HomeController: UIViewController {
    
    
    @IBOutlet weak var topCollection: UICollectionView!
    @IBOutlet weak var catCollect: UICollectionView!
    @IBOutlet weak var specialCollct: UICollectionView!
    @IBOutlet weak var seeAllCollect: UICollectionView!
    
    
    private let homeProfileViewModel = HomeProfileViewModel()
    private let productsviewModel = ProductsViewModel()

    override func viewDidLoad() {
        super.viewDidLoad()
        configureNavBar()
        collectionSetup()
        isSucced()
        
        getData()
        
    }
    

    
    
    func isSucced() {
        productsviewModel.successCallback = { [weak self] in
            self?.topCollection.reloadData()
            self?.catCollect.reloadData()
            self?.specialCollct.reloadData()
            self?.seeAllCollect.reloadData()

        }
    }

    
    func getData() {
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
    
    
    
    
    
}


//MARK: - SerchBar Methods

//extension HomeController: UISearchBarDelegate {
//    func searchBarTextDidBeginEditing(_ searchBar: UISearchBar) {
//        let searchVC = SearchController()
//        navigationController?.pushViewController(searchVC, animated: true)
//        
//    }
//    
//}





extension HomeController: UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout {
    
//    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
//        return 20
//    }
    
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
            cell.configure(data: productsviewModel.seeAllProducts[indexPath.row])
            
            return cell
        case catCollect:
            guard let cell = catCollect.dequeueReusableCell(withReuseIdentifier: "\(MidCollectionCell.self)", for: indexPath) as? MidCollectionCell else { return UICollectionViewCell() }
            cell.configure(data: productsviewModel.allCategories, indexPath: indexPath)

            return cell
        case specialCollct:
            guard let cell = specialCollct.dequeueReusableCell(withReuseIdentifier: "\(ThirdCollectionCell.self)", for: indexPath) as? ThirdCollectionCell else { return UICollectionViewCell() }
            cell.configure(data: productsviewModel.specialProducts[indexPath.row])
            return cell
        
        case seeAllCollect:
            guard let cell = seeAllCollect.dequeueReusableCell(withReuseIdentifier: "\(SeeAllCollectionCell.self)", for: indexPath) as? SeeAllCollectionCell else { return UICollectionViewCell() }
            cell.configure(data: productsviewModel.seeAllProducts[indexPath.row])
            return cell
        default:
            return UICollectionViewCell()
        }
    }
    
    
    
    

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {

        if (topCollection != nil) {

           return CGSize(width: (topCollection.frame.width / 3), height: (topCollection.frame.height))

        } else if  (catCollect != nil) {

            return CGSize(width: (catCollect.frame.width - 13) , height: (catCollect.frame.height) - 41)

        }else {

            return collectionView.contentSize
        }


    }
    
    
//    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
//        switch collectionView {
//        case topCollection:
//            return CGSize(width: topCollection.frame.width / 3 , height: (topCollection.frame.height))
////        case catCollect:
////            return CGSize(width: homeView.productCollection.frame.width / 2 - 10, height: homeView.productCollection.frame.width / 2 )
////        case specialCollct:
////
////        case seeAllCollect:
//        default:
//            return CGSize(width: 20, height: 20)
//        }
//

//}
    
    
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 10
    }

    
    
    
    
    

    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        switch collectionView {

//        case topCollection:
//            guard let productId = productsviewModel.seeAllProducts[indexPath.row].id else { return }
//
//
//        case catCollect:
//            let category = productsviewModel.allCategories[indexPath.row]
//            if category == "All" {
//                productsviewModel.fetchAllProducts()
//            } else {
////                productsviewModel.fetchProductByCategory(category)
//                productsviewModel.fetchAllProducts()
//            }
//
//
//
//        case specialCollct:
//            guard let productId = productsviewModel.specialProducts[indexPath.row].id else { return }
////            productsviewModel.fetchSingleProduct(productId: productId)
//
//        case seeAllCollect:
//            guard let productId = productsviewModel.seeAllProducts[indexPath.row].id else { return }
//


        default:
            return print("Did not show next VC")
        }
    }
    
    
    
    
}




////MARK: - ProductsViewModelDelegate
//
//extension HomeController: ProductsViewModelDelegate {
//    func didFetchProductsByCategorySuccessful() {
//        
//    }
//    
//    func didFetchSingleProduct(_ product: Product) {
//        
//    }
//    
//    func didFetchCartCountSuccessful() {
//        
//    }
//    
// 
//
////    func didFetchSingleProduct(_ product: Product) {
////        let controller = ProductDetailController(product: product)
////        navigationController?.pushViewController(controller, animated: true)
////    }
//    
//    func didOccurError(_ error: Error) {
//        print(error.localizedDescription)
//    }
//    func didFetchSpecialProductsSuccessful() {
//       
//        specialCollct.reloadData()
//    }
//    
//    func didFetchAllProductsSuccessful() {
//        topCollection.reloadData()
//        seeAllCollect.reloadData()
//        
//
//    }
//    
//    func didFetchAllCategories() {
//        catCollect.reloadData()
//    }
//    
////    func didFetchProductsByCategorySuccessful() {
////        homeView.productCollection.reloadData()
////    }
//    
//    func didUpdateWishListSuccessful() {
//    }
//   
////    func didFetchCartCountSuccessful() {
////        if let cartCount = productsViewModel.cart?.count {
////            if cartCount == 0 {
////                tabBarController?.tabBar.items?[2].badgeValue = nil
////            } else {
////                tabBarController?.tabBar.items?[2].badgeValue = "\(cartCount)"
////            }
////        }
////
////    }
//    
//    
//    
//}




