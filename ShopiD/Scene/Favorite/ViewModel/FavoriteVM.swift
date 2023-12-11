//
//  FavoriteVM.swift
//  ShopiD
//
//  Created by Dogukaim on 23.11.2023.
//

import Foundation
import Firebase
import FirebaseAuth
import FirebaseFirestoreSwift


protocol FavoriteVMDelegate: AnyObject {
    func didOccurError(_ error: Error)
    func didUpdatedFavlisSuccessful()
    func didFetchQuantity()
    func didFetchProductsFromFavListSuccessful()
    func didFetchSingleProduct(_ product: Product)
}





final class FavoriteVM {
    
    deinit {
        print("deinit FavoriteListVM")
    }
    
    
    private let database = Firestore.firestore()
    private let currentUser = Auth.auth().currentUser
    
    let manager = Service.shared
    
    weak var delegate: FavoriteVMDelegate?
    
    var favListProducts: [Product] = []
    var singleProduct: Product?
    
    
    var favlist: [String: Int]? = [:] {
        didSet {
            guard let favlist = favlist else { return }
            if favlist.isEmpty == true {
                
            }else {
                fetchProductFromFireStoreCollection(favlist: favlist)
            }
        }
    }
    
    
    
    init() {
        createUsersCollectilonIfNeeded()
    }
    
    
    
    func createUsersCollectilonIfNeeded() {
        guard let currentUser = currentUser else { return }
        let userRef = database.collection("Users").document(currentUser.uid)
        
        userRef.getDocument { document, error in
            if let document = document, !document.exists {
                
                userRef.setData(["dummy": "data"]) { error in
                    if let error = error {
                        self.delegate?.didOccurError(error)
                    }
                }
            }
        }
    }
    
    //MARK: - Update Favlisr in FireStore
    
    func updateFavList(productId: Int, quantity: Int) {
        guard let currentUser = currentUser else { return }
        let userRef = database.collection("Users").document(currentUser.uid)
        
        if quantity > 0 {
            userRef.updateData(["favList.\(productId)" : quantity]) { error in
                if let error = error {
                    self.delegate?.didOccurError(error)
                } else {
                    self.delegate?.didUpdatedFavlisSuccessful()
                }
            }
        } else {
            userRef.updateData(["favList.\(productId)" : FieldValue.delete()]) { error in
                if let error = error {
                    self.delegate?.didOccurError(error)
                } else {
                    self.delegate?.didUpdatedFavlisSuccessful()
                }
            }
        }
    }
    
    
    
    
    
    //MARK: - Get FavList from FireStore
    
    func fetchFavList() {
        
        guard let currentUser = currentUser else { return }
        
        let favlistRef = database.collection("Users").document(currentUser.uid)
        favlistRef.getDocument(source: .default) { documentData, error in
            if let documentData = documentData {
                self.favlist = documentData.get("favList") as? [String: Int]
                print(documentData.get("favList"))
                
                
            }
        }
    }
    
    
    func fetchQuantity(favlist: [String: Int]) {
        let productRef = database.collection("products")
        
        for (id, _) in favlist {
            let product = productRef.document(id)
            
            product.getDocument(source: .default) { documentData, error in
                guard let documentData = documentData else { return }
                
                if documentData.exists == true {
                    self.delegate?.didFetchQuantity()
                }else {
                    print("The product in the favList could not be found")
                }
            }
        }
    }
    
    
    
    func fetchProductFromFireStoreCollection(favlist: [String: Int]) {
        let productsRef = database.collection("products")
        
        for (id, _) in favlist {
            let product = productsRef.document(id)
            product.getDocument(as: Product.self) { result in
                switch result {
                case .failure(let error):
                    self.delegate?.didOccurError(error)
                    
                case .success(let product):
                    guard let productId = product.id else { return }
                    if !self.favListProducts.contains(where: { $0.id == productId }) {
                        self.favListProducts.append(product)
                    }
                    self.delegate?.didFetchProductsFromFavListSuccessful()
                }
            }
        }
    }
    
    
    //MARK: - FetchSingleProduct
    
    func fetchSingleProduct(_ productId: Int) {
        manager.fetchSingleProduct(type: .fetchSingleProducts(id: productId)) { product in
            if let product = product {
                self.singleProduct = product
                self.delegate?.didFetchSingleProduct(product)
            }
        } onError: { error in
            self.delegate?.didOccurError(error)
        }
        
    }
    
    
    //MARK: - GetProductIndexPath
    
    func getProductIndexPath(productId: Int) -> IndexPath {
        let index = favListProducts.firstIndex { product in
            product.id == productId
        }
        if let index = index {
            return IndexPath(item: index, section: 0)
        }
        return IndexPath()
    }
    
    
    func removeProduct(index: Int) {
        favListProducts.remove(at: index)
    }
    
    
    
    func addProductToFavoritesDetail(productId: Int, quantity: Int) {
        guard let currentUser = currentUser else { return }
        let userRef = database.collection("Users").document(currentUser.uid)
        
        userRef.updateData(["favList.\(productId)" : quantity]) { error in
            if let error = error {
                self.delegate?.didOccurError(error)
            } else {
                self.delegate?.didUpdatedFavlisSuccessful()
            }
        }
    }

    
    
}


