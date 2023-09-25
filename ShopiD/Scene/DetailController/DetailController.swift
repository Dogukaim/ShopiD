//
//  DetailController.swift
//  ShopiD
//
//  Created by Dogukaim on 7.09.2023.
//

import UIKit
import FirebaseDatabase
import Firebase



//MARK: - ProductDetailViewInterface Protocol

protocol ProductDetailViewInterface: AnyObject {
    func productDetailView(_ view: DetailController, quantity: Int)
    func productDetailView(_ view: DetailController, stepperValueChanged quantity: Int)
    func productDetailView(_ view: DetailController, quantity: Int, addToWishListButtonTapped button: UIButton)
}





//MARK: - ProductDetailProtocol
protocol DetailProtocol {

    var detailImagee: String { get }
    var detailName: String { get }
    var detailRati: String { get }
    var detailSold: String { get }
    var detailDescription: String { get }
    var detailPrice: String { get }
}



 final class DetailController: UIViewController {

    

    //MARK: - Properties
    private let productsViewModel = ProductsViewModel()
    private let productDetailViewModel = ProductDetailViewModel()
    
    
    weak var interface: ProductDetailViewInterface?
    
     var product: Product
    @IBOutlet weak var detaImage: UIImageView!
    @IBOutlet weak var detaName: UILabel!
    @IBOutlet weak var detaRating: UILabel!
    @IBOutlet weak var detaSold: UILabel!
    @IBOutlet weak var detaDescr: UILabel!
    @IBOutlet weak var detaPrice: UILabel!
    @IBOutlet weak var quantityLabl: UILabel!
    @IBOutlet weak var stepperPlusBut: UIButton!
    @IBOutlet weak var stepperLabel: UILabel!
    @IBOutlet weak var stepperMinusBut: UIButton!
    @IBOutlet weak var stepperStackView: UIStackView!
    @IBOutlet weak var favButDeta: UIButton!
     
     
    
    
    
     
    
    override func viewDidLoad() {
        super.viewDidLoad()

        toggleAddToWishListButton()
        setupDelegates()
    }
     
     required init?(coder: NSCoder) {
         fatalError("init(coder:) has not been implemented")
     }
    
     
     override func viewWillAppear(_ animated: Bool) {
         super.viewWillAppear(animated)
         self.navigationController?.isNavigationBarHidden = false
         if let productId = product.id {
             productDetailViewModel.fetchCart(productId: productId)
//             productDetailViewModel.fetchWishList(productId: productId)
         }
     }
     
     
     
    //MARK: Swifty
    
    var quantity = 1 {
        didSet {
            
            if quantity <= 0 {
                toggleStepperElements()
                quantity = 0
            }else if quantity > 10 {
                quantity = 10
            }
            stepperLabel.text = String(quantity)
        }
    }
    
    
    private func toggleStepperElements() {
        stepperStackView.isHidden = !stepperStackView.isHidden
        quantityLabl.isHidden = !quantityLabl.isHidden
        
    }
    
    func toggleAddToWishListButton() {
        let image = UIImage(systemName: "heart")
        let imageFilled = UIImage(systemName: "heart.fill")
        favButDeta.setImage(image, for: .normal)
        favButDeta.setImage(imageFilled, for: .selected)
    }
    
     @IBAction func addToCartButTapp(_ sender: Any) {
         if quantity <= 0 {
             quantity = 1
             stepperStackView.isHidden = false
             quantityLabl.isHidden = false
         }
         stepperStackView.isHidden = false
         quantityLabl.isHidden = false
         self.interface?.productDetailView(self, quantity: quantity)
     }
     
     @IBAction func stepperPlusButTap(_ sender: Any) {
         quantity = quantity + 1
         interface?.productDetailView(self, stepperValueChanged: quantity)
     }
     
     
     @IBAction func stepperMinusButTap(_ sender: Any) {
         quantity = quantity - 1
         interface?.productDetailView(self, stepperValueChanged: quantity)
     }
     
     @IBAction func addToFavButTap(_ sender: Any) {
         if favButDeta.isSelected == false {
             interface?.productDetailView(self, quantity: 1)
         } else {
             interface?.productDetailView(self, quantity: 0)
         }
         favButDeta.isSelected.toggle()
     }
     
     
     func configure(data: DetailProtocol) {

        detaImage.downloadSetImage(url: data.detailImagee)
        detaName.text = data.detailName
        detaRating.text = data.detailRati
        detaSold.text = "\(data.detailSold)"
        detaDescr.text = data.detailDescription
        detaPrice.text = data.detailPrice
        detaPrice.layer.cornerRadius = 15
    }
     
     //MARK: - Setup Delegates
     
     private func setupDelegates() {
        
         productDetailViewModel.delegate = self
     }
     

}


//MARK: - ProductDetailModelDelegate

extension DetailController: ProductDetailViewModelDelegate {
   
    func didOccurError(_ error: Error) {
        print(error.localizedDescription)
    }
    
    func didUpdateCartSuccessful(quantity: Int) {
        if let productId = product.id {
            productDetailViewModel.fetchCart(productId: productId)
        }
        
    }
    
    func didFetchCartCountSuccessful() {
        if let cartCount = productDetailViewModel.cart?.count {
            if cartCount == 0 {
                tabBarController?.tabBar.items?[2].badgeValue = nil
            } else {
                tabBarController?.tabBar.items?[2].badgeValue = "\(cartCount)"
            }
        }
    }
    
    func didFetchCartCostSuccessful(productId: Int, quantity: Int) {
        if let cost = productDetailViewModel.cartCost {
            detaPrice.text = "$\(cost)"
            stepperStackView.isHidden = false
            quantityLabl.isHidden = false
            
        } else {
            stepperStackView.isHidden = true
            quantityLabl.isHidden = true
        }
        
    }
    
    func didFetchWishListSuccessful(productId: Int) {
        if productId == product.id {
            favButDeta.isSelected = true
        } else {
            favButDeta.isSelected = false
            
        }
    }
    
    
}



//MARK: - ProductDetailInterface

extension DetailController: ProductDetailViewInterface {
    func productDetailView(_ view: DetailController, quantity: Int) {
        guard let id = product.id else { return }
        productsViewModel.updateWishList(productId: id, quantity: quantity)
    }
    
    func productDetailView(_ view: DetailController, stepperValueChanged quantity: Int) {
        guard let id = product.id else { return }
        productDetailViewModel.updateCart(productId: id, quantity: quantity)
    }
    
    func productDetailView(_ view: DetailController, quantity: Int, addToWishListButtonTapped button: UIButton) {
        guard let id = product.id else { return }
        productDetailViewModel.updateCart(productId: id, quantity: quantity)
    }
    
   
    
}
