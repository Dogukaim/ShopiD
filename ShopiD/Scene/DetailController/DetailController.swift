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
    
    
    
    var productID: Int?
    
    
    
    
    var quantity = 1 {
        didSet {
            if quantity <= 0 {
                toggleStepperElements()
                quantity = 0
            } else if quantity > 10 {
                quantity = 10
            }
            stepperLabel.text = String(quantity)
        }
    }
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        viewModel.view = self
        if let productID {
            viewModel.fetchSingleProduct(productId: productID)
        }
        
//        toggleAddToWishListButton()
        
        
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
             
         }
         stepperStackView.isHidden = false
         
     }
     
     @IBAction func stepperPlusButTap(_ sender: Any) {

     }
     
     
     @IBAction func stepperMinusButTap(_ sender: Any) {

         
     }
     
    
    
    
     @IBAction func addToFavButTap(_ sender: Any) {

     }

}

//MARK: - DetailViewInterface
extension DetailController: DetailViewInterface {
    func didOccurError(errorMsg: String) {
        
    }
    
    
    func configure(with data: DetailProtocol) {
       detaImage.downloadSetImage(url: data.detailImagee)
       detaName.text = data.detailName
       detaRating.text = data.detailRati
       detaSold.text = "\(data.detailSold)"
       detaDescr.text = data.detailDescription
       detaPrice.text = data.detailPrice
   }

    
    
}
 
