//
//  FilterCategory.swift
//  ShopiD
//
//  Created by Dogukaim on 21.11.2023.
//


import UIKit


protocol FilterCategoryDelegate: AnyObject {
    func filterCategoryDidDismiss()
    func filterCategoryDidDismiss(selectedCategory: String?)
    func didSelectCategory(_ category: String)
    func didSelectAllCategories()
    func updateBarButtonIcon()
}






class filterCategory: UIViewController {
    
    @IBOutlet weak var filterCollection: UICollectionView!
    @IBOutlet weak var containerView: UIView!
    @IBOutlet weak var backgroundTap: UIView!
    
    
    
    private let categorVM = HomeViewModel()
    
    private let searchhVM = SearchViewModel()
    
    weak var delegate: FilterCategoryDelegate?
    
    var selectedCategory: String?
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        getData()
        collectionSetup()
        isSucced()
        
        
        
    }
    
    
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        
        
    }
    
    
 
    
    
    private func collectionSetup() {
        
        let nib = UINib(nibName: "MidCollectionCell", bundle: nil)
        filterCollection.register(nib, forCellWithReuseIdentifier: "MidCollectionCell")
        
        containerView.layer.cornerRadius = 30
        
        
        let tapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(backgroundTapped))
        backgroundTap.addGestureRecognizer(tapGestureRecognizer)
    }
    
    
    
    @objc func backgroundTapped() {
        dismiss(animated: true) {
            print("Dismiss completion")
            self.delegate?.filterCategoryDidDismiss()
            self.delegate?.filterCategoryDidDismiss(selectedCategory: self.selectedCategory)
            self.delegate?.updateBarButtonIcon()
        }
        
        
    }
    
    
    
    func didSeletCategory(_ category: String) {
        selectedCategory = category
        delegate?.didSelectCategory(category)
    }
    
    
    
    
    private func getData() {
        categorVM.fetchOnlyCategory()
    }
    
    private func isSucced() {
        categorVM.successCallback = { [weak self] in
            self?.filterCollection.reloadData()
        }
    }
    
}


extension filterCategory: UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        switch collectionView {
            
        case filterCollection:
            return categorVM.allCategories.count
        default:
            return 0
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        switch collectionView{
        case filterCollection:
            guard let cell = filterCollection.dequeueReusableCell(withReuseIdentifier: "\(MidCollectionCell.self)", for: indexPath) as? MidCollectionCell else { return UICollectionViewCell() }
            cell.configure(data: categorVM.allCategories, indexPath: indexPath)
            
            return cell
        default:
            return UICollectionViewCell()
        }
    }
    
    
    
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let selectedCategory = categorVM.allCategories[indexPath.item]
        
        
        delegate?.didSelectCategory(selectedCategory)
        
        
        didSeletCategory(selectedCategory)
        
        
        if selectedCategory == "All" {
            delegate?.didSelectAllCategories()
        } else {
            
            searchhVM.fetchProductByCategory(selectedCategory)
        }
        
        
//        dismiss(animated: true, completion: nil)
        
        dismiss(animated: true) {
            // 6. Sağ üst köşedeki UIBarButton'ın ikonunu güncelliyoruz
            self.delegate?.updateBarButtonIcon()
        }
    }
    
    
    
}
