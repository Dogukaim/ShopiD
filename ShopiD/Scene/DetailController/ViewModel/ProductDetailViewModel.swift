//
//  ProductDetailViewModel.swift
//  ShopiD
//
//  Created by Dogukaim on 25.09.2023.
//

import Foundation
import Firebase
import FirebaseFirestore


protocol ProductDetailViewModelDelegate: AnyObject {
    func didOccurError(_ error: Error)
    func didFetchSingleProduct(_ product: Product)
//    func didUpdateCartSuccessful(quantity: Int)
//    func didFetchCartCountSuccessful()
//    func didFetchCartCostSuccessful(productId: Int, quantity: Int)
//    func didFetchWishListSuccessful(productId: Int)

}



final class ProductDetailViewModel {
    
    //MARK: - Properties
    
    let manager = Service.shared
    
    
    //MARK: - SearchViewModelDelegate
    
    weak var delegate: ProductDetailViewModelDelegate?
    
    
    //MARK: - Products
    
    var products: [Product] = []
    var singleProduct: Product?
    
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
    
    
}






//final class ProductDetailViewModel {
//
//
////    weak var delegate: ProductDetailViewModelDelegate?
//
//    private let database = Firestore.firestore()
//    private let currentUser = Auth.auth().currentUser
//
//
//    var cartCost: Double?
//    var singleProduct: Product
//    var detailProduct: [Product] = []
    
    
    
    
//    func fetchSingleProduct(_ productId: Int) {
//        manager.fetchSingleProduct(type: .fetchSingleProducts(id: productId)) { product in
//            if let product = product {
//                self.singleProduct = product
//                self.delegate?.didFetchSingleProduct(product)
//            }
//        } onError: { error in
//            self.delegate?.didOccurError(error)
//        }
//
//    }
    
    
    
    
    
    
    
    
    
    
    
//
//    var cart: [String: Int]? = [:]
//    var wishList: [String: Int]? = [:]

//    //MARK: - FetchCart
//
//    func fetchCart(productId: Int) {
//        guard let currentUser = currentUser else { return }
//
//        let cartRef = database.collection("Users").document(currentUser.uid)
//        cartRef.getDocument(source: .default) { documentData, error in
//            if let documentData = documentData {
//                self.cart = documentData.get("cart") as? [String: Int]
//                self.delegate?.didFetchCartCountSuccessful()
//                if let cart = self.cart {
//                    self.fetchProductCostInCart(productId: productId, cart: cart)
//                }
//            }
//        }
//    }
//
//
//
//
//    func fetchProductCostInCart(productId: Int, cart: [String: Int]) {
//        let productsRef = database.collection("products")
//        let product = productsRef.document("\(productId)")
//        if let quantity = cart["\(productId)"] {
//
//            product.getDocument { documentData, error in
//                guard let documentData = documentData else { return }
//                guard let price = documentData.get("price") as? Double else { return }
//                let roundedCost = Double(price * Double(quantity)).rounded(toPlaces: 2)
//                self.cartCost = roundedCost
//                self.delegate?.didFetchCartCostSuccessful(productId: productId, quantity: quantity)
//            }
//        } else {
//            product.getDocument { documentData, error in
//                guard let documentData = documentData else { return }
//                guard let price = documentData.get("price") as? Double else { return }
//                let cost = Double(price * Double(1))
//                self.cartCost = cost
//                self.delegate?.didFetchCartCostSuccessful(productId: productId, quantity:0)
//            }
//
//        }
//    }
//
//
//
//    //MARK: - Update Cart in Firestore
//
//    func updateCart(productId: Int, quantity: Int) {
//        guard let currentUser = currentUser else { return }
//
//        let userRef = database.collection("Users").document(currentUser.uid)
//
//        if quantity > 0 {
//            userRef.updateData(["cart.\(productId)" : quantity]) { error in
//                if let error = error {
//                    self.delegate?.didOccurError(error)
//                } else {
//                    self.delegate?.didUpdateCartSuccessful(quantity: quantity)
//                }
//            }
//        } else {
//            userRef.updateData(["cart.\(productId)" : FieldValue.delete()]) { error in
//                if let error = error {
//                    self.delegate?.didOccurError(error)
//                } else {
//                    self.delegate?.didUpdateCartSuccessful(quantity: 0)
//                }
//            }
//        }
//
//    }

    
//}
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    

    
    
//}
