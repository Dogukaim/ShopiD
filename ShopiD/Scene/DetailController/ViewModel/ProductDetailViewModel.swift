//
//  ProductDetailViewModel.swift
//  ShopiD
//
//  Created by Dogukaim on 25.09.2023.
//

import Foundation
import Firebase
import FirebaseFirestore



protocol DetailViewModelInterface: AnyObject {
    var view: DetailViewInterface? { get set }
    
    func fetchSingleProduct(productId id: Int)
    
}


final class DetailViewModel {
    
    let manager = Service.shared
    
    //MARK: - References
    weak var view: DetailViewInterface?
    
    private let database = Firestore.firestore()
    private let currentUser = Auth.auth().currentUser
    
    var cart: [String: Int]? = [:]
    
    
    
    //    func fetchCart(productId: Int) {
    //        guard let currentUser = currentUser else { return }
    //            let cartRef = database.collection("Users").document(currentUser.uid)
    //        cartRef.getDocument(source: .default) { documentData, error in
    //            if let documentData = documentData {
    //                self.cart = documentData.get("cart") as? [String: Int]
    //                self.view.didFetchCartCountSuccessful()
    //            }
    //        }
    //    }
    
    
    
    
    
}

extension DetailViewModel: DetailViewModelInterface {
    
    
    
    func fetchSingleProduct(productId id: Int) {
        manager.fetchSingleProduct(type: .fetchSingleProducts(id: id)) { [weak self] product in
            guard let self = self else { return }
            
            if let product = product {
                // remove loading
                self.view?.configure(with: product)
                
            }
            
        } onError: { [weak self] error in
            guard let self = self else { return }
            // show error
            self.view?.didOccurError(errorMsg: error.localizedDescription)
        }
        
    }
    
    
    
}
