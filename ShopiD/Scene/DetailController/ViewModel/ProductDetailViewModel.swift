//
//  ProductDetailViewModel.swift
//  ShopiD
//
//  Created by Dogukaim on 25.09.2023.
//

import Foundation
import Firebase
import FirebaseFirestore



import Foundation
import Firebase
import FirebaseFirestore

protocol DetailViewModelInterface {
    var view: DetailViewInterface? { get set }

    func fetchSingleProduct(productId id: Int)
}

final class DetailViewModel {
    
    let manager = Service.shared
    
    //MARK: - References
    weak var view: DetailViewInterface?
    
}

extension DetailViewModel: DetailViewModelInterface {
    
    func fetchSingleProduct(productId id: Int) {
        // add loading
        
        manager.fetchSingleProduct(type: .fetchSingleProducts(id: id)) { [weak self] product in
            guard let self else { return }
            
            if let product = product {
                // remove loading
                view?.configure(with: product)
            }
            
        } onError: { [weak self] error in
            guard let self else { return }
            // show error
            view?.didOccurError(errorMsg: error.localizedDescription)
        }
        
    }
}
