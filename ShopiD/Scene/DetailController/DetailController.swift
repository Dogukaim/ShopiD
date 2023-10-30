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



  class DetailController: UIViewController {

    

    //MARK: - Properties
    private let productsViewModel = ProductsViewModel()
    var product: Product
      
    static let detailSegue = "detailSegue"
    //MARK: - Init methods
    init(product: Product) {
        self.product = product
        super.init(nibName: nil, bundle: nil)
    }
      
      required init?(coder: NSCoder) {
          fatalError("init(coder:) has not been implemented")
      }
      
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
        toggleStepperElements()
    }
     

     //MARK: Setup Delegate
      
      
      override func viewWillAppear(_ animated: Bool) {
          super.viewWillAppear(animated)
          self.navigationController?.isNavigationBarHidden = false
          if let productId = product.id {
              productsViewModel.fetchSingleProduct(productId: productId)
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

     }
     
     @IBAction func stepperPlusButTap(_ sender: Any) {

     }
     
     
     @IBAction func stepperMinusButTap(_ sender: Any) {

         
     }
     
     @IBAction func addToFavButTap(_ sender: Any) {

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
     
     

}

