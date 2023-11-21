//
//  FilterCategory.swift
//  ShopiD
//
//  Created by Dogukaim on 21.11.2023.
//


import UIKit



class filterCategory: UIViewController {
    
    @IBOutlet weak var filterCollection: UICollectionView!
    @IBOutlet weak var containerView: UIView!
    
    
    private let categorVM = HomeViewModel()
    
    
    

    override func viewDidLoad() {
        super.viewDidLoad()
        getData()
        collectionSetup()
        isSucced()
    }
    
    
    
        
    @IBAction func closeButton(_ sender: Any) {
        
    }
    
    
    private func collectionSetup() {
        
        let nib = UINib(nibName: "MidCollectionCell", bundle: nil)
        filterCollection.register(nib, forCellWithReuseIdentifier: "MidCollectionCell")
        
        containerView.layer.cornerRadius = 30
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
    
        
    
    
}
