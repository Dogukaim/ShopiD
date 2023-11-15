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


    
   


final class DetailController: UIViewController  {
    

    



      
    
      
   
      
      
      

 
      
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


    }

      
    
      
     //MARK: Setup Delegate
      
      private func configureContro() {
          
//          
//          guard let detail = deta else { return }
//          detaImage.downloadSetImage(url: detail.image ?? "" )
//          detaName.text = detail.title
////          detaRating.text = productt
//          detaRating.text = detail.detailRati
//          detaDescr.text = detail.productDescription
//          detaPrice.text = String(describing: detail.price)
//
          
          
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
     
//
     func configure(data: DetailProtocol) {

        detaImage.downloadSetImage(url: data.detailImagee)
        detaName.text = data.detailName
        detaRating.text = data.detailRati
        detaSold.text = "\(data.detailSold)"
        detaDescr.text = data.detailDescription
        detaPrice.text = data.detailPrice
    }

     
      
//      private func setData() {
//          detaImage.downloadSetImage(url: viewModel.imageD )
//          detaName.text = viewModel.nameD
//          detaRating.text = viewModel.detaRatig
//          detaDescr.text = viewModel.detaDes
//          detaPrice.text = viewModel.detaPr
//          
//      }
//      
 
    
    
}
 
