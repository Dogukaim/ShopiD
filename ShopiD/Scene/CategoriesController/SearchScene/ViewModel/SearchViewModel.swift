//
//  SearchViewModel.swift
//  ShopiD
//
//  Created by Dogukaim on 16.11.2023.
//

import Foundation


protocol SearchViewModelDelegate: AnyObject {
    func didFetchSearchProductsSucc()
    func didOccurError(_ error: Error)
    func didFetchProductsByCategorySuc()
    func didSelectAllCategoriess()
}







class SearchViewModel {
    
    
    let manager = Service.shared
    weak var delegate: SearchViewModelDelegate?
    
    var allProducts: [Product] = []
    var filteredProducts: [Product] = []
    
    var searchProduct : [Product] = []
    
    
    
    
    
    func fetchAllProducts() {
        
        manager.fetchProducts(type: .fetchAllProducts) { products in
            if let products = products {
                
                
                self.allProducts = products
                
                
                self.delegate?.didFetchSearchProductsSucc()
            }
        } onError: { error in
            self.delegate?.didOccurError(error)
        }
    }
    
    
    
    func fetchProductByCategory(_ category: String) {
        manager.fetchProductByCategory(type: .fetchProdudctByCategory(category: category)) { products in
            if let products = products {
                self.allProducts = products
                self.delegate?.didFetchProductsByCategorySuc()
                
                if category == "All" {
                    self.delegate?.didSelectAllCategoriess()
                }
            }
        } onError: { error in
            self.delegate?.didOccurError(error)
        }
        
    }
    
    
}


