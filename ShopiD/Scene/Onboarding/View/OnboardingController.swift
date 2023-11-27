//
//  OnboardingController.swift
//  ShopiD
//
//  Created by Dogukaim on 1.09.2023.
//

import UIKit




class OnboardingController: UIViewController {

    
    //MARK: Constants
    private var currentpage = 0
    var slides: [OnboardingSlide] = []
    

        
    //MARK: - Onboarding Model Array
    

    
    
    
    @IBOutlet weak var collection: UICollectionView!
    @IBOutlet weak var pageControler: UIPageControl!
    @IBOutlet weak var continueButton: UIButton!
    
    
    
    @IBOutlet weak var skipBut: UIButton!
    
    var currentPage = 0 {
        didSet {
            pageControler.currentPage = currentPage

              if  currentPage == slides.count - 1  {
               

                  continueButton.setTitle("Get Started", for: .normal)
            }else {

                
                continueButton.setTitle("Next", for: .normal)
                }
            }
        }

    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureCollectionView()
       

    }

    
    
    var slideForPageControl: [OnboardingSlide] = []
 
    


    
    @IBAction func skipButtonTap(_ sender: UIButton) {
        let controler = storyboard?.instantiateViewController(identifier: "SignInController") as! SignInController
        controler.modalPresentationStyle = .fullScreen
        controler.modalTransitionStyle = .flipHorizontal
        present(controler,animated: true,completion: nil)
    }
    
    
    @IBAction func continueButtonTap(_ sender: UIButton)  {
        if currentpage == slides.count - 1 {
               let controler = storyboard?.instantiateViewController(identifier: "SignInController") as! SignInController
               controler.modalPresentationStyle = .fullScreen
               controler.modalTransitionStyle = .flipHorizontal
               present(controler,animated: true,completion: nil)
           } else {
               currentpage += 1
               let indexpath = IndexPath(item: currentpage, section: 0)
               collection.scrollToItem(at: indexpath, at: .centeredHorizontally, animated: true)

 
               let visibleIndexPaths = collection.indexPathsForVisibleItems
               if let firstVisibleIndexPath = visibleIndexPaths.first {
                   let nextCell = collection.cellForItem(at: firstVisibleIndexPath) as? OnboardingViewCell
                   nextCell?.configure(data: slides[currentpage])
                   pageControler.currentPage = currentpage
               }
           }
        
    }
    
    
    
    //MARK: Config Collection set slide
    private func configureCollectionView() {
        
        slides = ([OnboardingSlide(image: UIImage(named: "Onboarding1") ?? UIImage(), title: "Discover and Order the Best Products." , subTitle: "The things you're looking for are here."),
                                  OnboardingSlide(image: UIImage(named: "Onboarding2") ?? UIImage(), title: "What's nearby?", subTitle: "Near me and location Scan."),
                                  OnboardingSlide(image: UIImage(named: "Onboarding3") ?? UIImage(), title: "Shopping time", subTitle: "Your needs are at the doorstep")])
    
        
        
        pageControler.numberOfPages = slides.count
        
    }
    
    
    
}


//MARK: - CollectionView Methods

extension OnboardingController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return slides.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "OnboardingCell", for: indexPath) as! OnboardingViewCell
        cell.configure(data: slides[indexPath.item])
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: collectionView.frame.width, height: collectionView.frame.height)
    }
    
    
}


//MARK: - OnboardingViewInterface Methods

extension OnboardingController {
    
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        
        let width = scrollView.frame.width
        currentpage = Int(scrollView.contentOffset.x / width)
        pageControler.currentPage = currentpage
    }
}

// MARK: - UILabel Extension
extension UILabel {
    
    func colorString(text: String?, coloredText: String?, color: UIColor? = .red) {
        
        let attributedString = NSMutableAttributedString(string: text!)
        let range = (text! as NSString).range(of: coloredText!)
        attributedString.setAttributes([NSAttributedString.Key.foregroundColor: color!],
                                       range: range)
        self.attributedText = attributedString
    }
}

  
