//
//  SearchViewModel.swift
//  ShopiD
//
//  Created by Dogukaim on 16.11.2023.
//

import Foundation


protocol SearchViewModelDelegate {
    func didFetchAllProductsSucc()
    func didOccurError(_ error: Error)
}


class SearchViewModel {
        
    
        let manager = Service.shared
        weak var delegate: HomeVMDelegate?
        
        var allProducts: [Product] = [] // Tüm ürünleri içeren dizi
        var filteredProducts: [Product] = [] // Filtrelenmiş ürünleri içeren dizi

        func filterContentForSearchText(_ searchText: String?) {
            guard let searchText = searchText, !searchText.isEmpty else {
                // Arama terimi boşsa veya nil ise, tüm ürünleri göster
                filteredProducts = allProducts
                return
            }

            // Arama terimine göre ürünleri filtrele
            filteredProducts = allProducts.filter { $0.title!.lowercased().contains(searchText.lowercased()) }
        }
    
    func fetchAllProducts() {
        
        manager.fetchProducts(type: .fetchAllProducts) { products in
            if let products = products {
                self.allProducts = products
                self.delegate?.didFetchAllProductsSucc()
//                self.successCallback?()

            }
        } onError: { error in
            self.delegate?.didOccurError(error)
        }
    }
        
    
    
//    func fetchpro(searchtext: String) {
//        
//        manager.fetchProducts(type: .fetchAllProducts) { products in
//            if let products = products {
//                self.allProducts = products ?? []
//                self?.allProducts
//            }
//        } onError: { <#AFError#> in
//            <#code#>
//        }
//
//    }
    
    
    func fetchProducts(forSearchText searchText: String) {
        manager.fetchProducts(type: .fetchAllProducts) { products in
            if let products = products {
                // Arama terimine göre filtreleme işlemi
                let filteredProducts = searchText.isEmpty ? products : products.filter {
                    $0.name.lowercased().contains(searchText.lowercased())
                }

                // Filtrelenmiş ürünleri delegenize (veya başka bir işlevsel bloğa) bildirin
                self.delegate?.didFetchFilteredProducts(filteredProducts)
            }
        } onError: { error in
            self.delegate?.didOccurError(error)
        }
    }
    

}

