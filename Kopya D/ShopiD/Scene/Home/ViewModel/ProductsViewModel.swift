//
//  ProductsViewModel.swift
//  ShopiD
//
//  Created by Dogukaim on 15.09.2023.
//



import Firebase
import FirebaseAuth
import FirebaseFirestore

protocol ProductsViewModelDelegate: AnyObject {
    func didOccurError(_ error: Error)
    func didFetchSpecialProductsSuccessful()
    func didFetchAllProductsSuccessful()
    func didFetchAllCategories()
    func didFetchSingleProduct(_ product: Product)

}

final class ProductsViewModel {
    
    weak var delegate: ProductsViewModelDelegate?
    
    let manager = Service.shared
    
    private let database = Firestore.firestore()
    private let currentUser = Auth.auth().currentUser
    
    var seeAllProducts: [Product] = []
    var specialProducts: [Product] = []
    var productsByCategory: [Product] = []
    var singleProduct: Product?
    var allCategories = Categories()
    
    var successCallback: (()->())?
    
    var wishList: [String: Int]? = [:]
        
    var cart: [String : Int]? = [:]
    
    func fetchAllProducts() {
        manager.fetchProducts(type: .fetchAllProducts){ products in
            if let products = products {
                self.seeAllProducts = products
                self.productsByCategory = products
                self.allProductsToFirestore(products: products)
                self.delegate?.didFetchAllProductsSuccessful()
                self.successCallback?()
            }
        } onError: { error in
            self.delegate?.didOccurError(error)
        }
        
    }
    
    func fetchSpecialProducts() {
        manager.fetchProducts(type: .fetchAllProducts) { products in
            if let products = products {
                self.specialProducts = products.shuffled()
            
                self.delegate?.didFetchSpecialProductsSuccessful()
                self.successCallback?()
            }
        } onError: { error in
            self.delegate?.didOccurError(error)
        }

    }
    
    func fetchSingleProduct(productId id: Int) {
        manager.fetchSingleProduct(type: .fetchSingleProducts(id: id)) { product in
            if let product = product {
                self.singleProduct = product
                self.delegate?.didFetchSingleProduct(product)
                
            }
        } onError: { error in
            self.delegate?.didOccurError(error)
        }


    }
    
    func fetchOnlyCategory() {
        manager.fetchCategory { categories in
            if let categories = categories {
                self.allCategories = categories
                self.allCategories.insert("All", at:0)
                self.delegate?.didFetchAllCategories()
                self.successCallback?()
            }

        } onError: { error in
            self.delegate?.didOccurError(error)
        }

    }

    
    func allProductsToFirestore(products: [Product]?) {
        guard let products = products else { return }

        products.forEach { product in
            guard let id = product.id else { return }
            database.collection("products").document("\(id)").setData(product.dictionary) { error in
                if let error = error {
                    self.delegate?.didOccurError(error)
                }
            }

        }
    }

    
    
    
    //MARK: - FetchWishList
    
    func fetchWishList() {
        guard let currentUser = currentUser else { return }
        
        let wishListRef = database.collection("Users").document(currentUser.uid)
        wishListRef.getDocument(source: .default) { documentData, error in
            if let documentData = documentData {
                self.wishList = documentData.get("wishList") as? [String: Int]
            }
        }
    }


 
  
}
