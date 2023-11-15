//
//  ProductDetailViewModel.swift
//  ShopiD
//
//  Created by Dogukaim on 25.09.2023.
//

import Foundation
import Firebase
import FirebaseFirestore




protocol DetailDelegate: AnyObject {
    func didGetProductDetail(isDone: Bool)
}



class DetailViewModel {

    
    
    let manager = Service.shared
    
    //MARK: - SearchViewModelDelegate
    
    //MARK: - Products
    var productId: Int
    
    init(id: Int) {
        self.productId = id
    }
    
    private func fetchSingleProduct(productId id: Int) {
            manager.fetchSingleProduct(type: .fetchSingleProducts(id: id)) { [weak self] product in
                guard let self else { return }
                
                if let product = product {
                    view?.didFecthProductDetail()
                    view?.configure(data: product)
                }
                
            } onError: { [weak self] error in
                guard let self else { return }
                
                view?.didOccurError(error.localizedDescription)
            }
            
        }
    
}
