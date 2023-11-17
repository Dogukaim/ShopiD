//
//  HomeViewModel.swift
//  ShopiD
//
//  Created by Dogukaim on 3.11.2023.
//

import Foundation



protocol HomeVMDelegate: AnyObject {
    
    func didFetchAllProductsSucc()
    func didOccurError(_ error: Error)
    func didFetchSingleProduct(_ product: Product)
    func didFetchAllCategories()
    func didFetchSpecialProductsSuccessful()
}


final class HomeViewModel {
    
    let manager = Service.shared
    weak var delegate: HomeVMDelegate?
    
    var singleProduct: Product?
    var allCategories = Categories()
    var successCallback: (()->())?
    
    var seeAllProducts:  [Product] = []
    var specialProducts: [Product] = []
    
    var allProduct = [Product]()
    var productsByCategory = [Product]()
    var searchCategory = [Categories]()
    
    
    
    var productID: Int?
    
//    var products: [Product] = []
    
    static let shared = HomeViewModel()
    
    
    
    
    func fetchAllProducts() {
        
        manager.fetchProducts(type: .fetchAllProducts) { products in
            if let products = products {
                self.seeAllProducts = products
                self.delegate?.didFetchAllProductsSucc()
                self.successCallback?()

            }
        } onError: { error in
            self.delegate?.didOccurError(error)
        }
    }
    
    
    
    func fetchOnlyCategory() {
        manager.fetchCategory { categories in
            if let categories = categories {
                self.allCategories = categories
                self.allCategories.insert("All", at: 0)
                self.delegate?.didFetchAllCategories()
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
    
  

    
    func fetchSpecialProducts() {
        
        manager.fetchProducts(type: .fetchAllProducts) { products in
            if let products = products  {
                self.specialProducts = products.shuffled()
                self.delegate?.didFetchSpecialProductsSuccessful()
                self.successCallback?()
            }
        } onError: { error in
            self.delegate?.didOccurError(error)
        }

    }
    
    

    
    
    
    
    func fetchProductByCategory(_ category: String) {
        manager.fetchProductByCategory(type: .fetchProdudctByCategory(category: category)) { products in
            if let products = products {
                self.productsByCategory = products
//                self.delegate?.didFetchProductsByCategorySuccessful()
                self.successCallback?()
            }
        } onError: { error in
            self.delegate?.didOccurError(error)
        }
        
    }
    
    
     
}
