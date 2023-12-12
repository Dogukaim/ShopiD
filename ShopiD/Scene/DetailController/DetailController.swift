//
//  DetailController.swift
//  ShopiD
//
//  Created by Dogukaim on 7.09.2023.
//

import UIKit
import FirebaseDatabase
import Firebase




//MARK: - ProductDetailProtocol
protocol DetailProtocol {
    var detailImagee: String { get }
    var detailName: String { get }
    var detailRati: String { get }
    var detailSold: String { get }
    var detailDescription: String { get }
    var detailPrice: String { get }
}

protocol DetailViewInterface: AnyObject {
    func configure(with product: DetailProtocol)
    func didOccurError(errorMsg: String)
    
}




final class DetailController: UIViewController  {
    
    
    @IBOutlet weak var detaDescr: UILabel!
    @IBOutlet weak var detaImage: UIImageView!
    @IBOutlet weak var detaName: UILabel!
    @IBOutlet weak var detaRating: UILabel!
    @IBOutlet weak var detaSold: UILabel!
    
    @IBOutlet weak var detaPrice: UILabel!
    @IBOutlet weak var quantityLabl: UILabel!
    @IBOutlet weak var stepperPlusBut: UIButton!
    @IBOutlet weak var stepperLabel: UILabel!
    @IBOutlet weak var stepperMinusBut: UIButton!
    @IBOutlet weak var stepperStackView: UIStackView!
    @IBOutlet weak var favButDeta: UIButton!
    
    
    
    
    private let viewModel = DetailViewModel()
    
    private let favoriteVM = FavoriteVM()
    
    private let favoriteController = FavoriteController()
    
    var productID: Int?
    
    var originalPrice: Double = 0.0
    
    private var isFavoriteButtonTapped = false
    
    var quantity = 1 {
        didSet {
            if quantity <= 0 {
                toggleStepperElements()
                quantity = 0
            } else if quantity > 10 {
                quantity = 10
            }
            stepperLabel.text = String(quantity)
            updatePrice()
        }
    }
    
    
    
    
    
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        viewModel.view = self
        if let productID {
            viewModel.fetchSingleProduct(productId: productID)
        }
        
        
        
    }
    
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        toggleStepperElements()
    }
    
    
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        // Her açılışta isFavoriteButtonTapped durumunu sıfırla
        isFavoriteButtonTapped = false
    }
    
    
    
    
    private func toggleStepperElements() {
        stepperStackView.isHidden = !stepperStackView.isHidden
        quantityLabl.isHidden = !quantityLabl.isHidden
        
    }
    
    func toggleAddToFavListButton() {
        let image = UIImage(systemName: "heart")
        let imageFilled = UIImage(systemName: "heart.fill")
        
        
        if !favButDeta.isSelected {
            favButDeta.setImage(imageFilled, for: .normal)
        } else {
            favButDeta.setImage(image, for: .normal)
        }
        
        
        favButDeta.isSelected.toggle()
    }
    
    
    
    @IBAction func addToCartButTapp(_ sender: Any) {
        
        if quantity <= 0 {
            quantity = 1
        }
        
        toggleStepperElements()
    }
    
    @IBAction func stepperPlusButTap(_ sender: Any) {
        quantity += 1
        updatePrice()
    }
    
    
    private func updatePrice() {
        let totalPrice = originalPrice * Double(quantity)
        detaPrice.text = String(format: "%.2f", totalPrice)
        
    }
    
    
    
    
    
    @IBAction func stepperMinusButTap(_ sender: Any) {
        
        quantity -= 1
        updatePrice()
    }
    
    
    
    
    @IBAction func addToFavButTap(_ sender: Any) {
        toggleAddToFavListButton()
        // Call the function to add the product to favorites
        if let productId = productID {
            favoriteVM.addProductToFavoritesDetail(productId: productId, quantity: 1)
        }
        
        
        
        isFavoriteButtonTapped = true
        
        
        if isFavoriteButtonTapped && favoriteController.favoriteBadgeCount == 0 {
            if let tabBarController = self.tabBarController,
               let viewControllers = tabBarController.viewControllers,
               viewControllers.count > 1,
               let favoriteController = viewControllers[1] as? FavoriteController {
                favoriteController.favoriteBadgeCount += 1
            }
        }
        
    }
    
}

//MARK: - DetailViewInterface
extension DetailController: DetailViewInterface {
    func didOccurError(errorMsg: String) {
        
    }
    
    
    func configure(with data: DetailProtocol) {
        
        
        let priceString = data.detailPrice.replacingOccurrences(of: "$", with: "")
        
        if let price = Double(priceString) {
            
            originalPrice = price
            updatePrice()
            
        } else {
            
            print("Error: transformation \(data.detailPrice)")
            
            return
        }
        
        
        detaImage.downloadSetImage(url: data.detailImagee)
        detaName.text = data.detailName
        detaRating.text = data.detailRati
        detaSold.text = "\(data.detailSold)"
        detaDescr.text = data.detailDescription
        detaPrice.text = "\(data.detailPrice)"
        
        
    }
    
    
    
}

