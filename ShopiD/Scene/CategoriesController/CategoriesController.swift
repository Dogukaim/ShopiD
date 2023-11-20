//
//  CategoriesController.swift
//  ShopiD
//
//  Created by Dogukaim on 7.09.2023.
//

import UIKit

class CategoriesController: UIViewController, UISearchBarDelegate {
    
    

    
    @IBOutlet weak var catCollectionn: UICollectionView!
    
    
    private let searchController = UISearchController(searchResultsController: nil)
    
    private let productsviewModel = HomeViewModel()
    private let searchVM = SearchViewModel()
    
    private let cellSpacing: CGFloat = 10
    
    
    var searching = false
    var searchedData: [Product] = []
    
    
    private weak var searchBar: UISearchBar? {
        return searchController.searchBar
    }
    
    var isSearchBarEmpty: Bool {
        return searchBar?.text?.isEmpty ?? true
    }
    var filteredProducts: [Product] = []
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        collectionSetup()
        isSucced()
        searchDelegate()
        getData()

    }
    
    func isSucced() {
        productsviewModel.successCallback = { [weak self] in
            self?.catCollectionn.reloadData()
            

        }
    }
    
    
    
    private func getData() {
        searchVM.fetchAllProducts()
        

    }
    
    
    private func collectionSetup() {
        
        catCollectionn.register(UINib(nibName: "\(CategoryCell.self)", bundle: nil), forCellWithReuseIdentifier: "\(CategoryCell.self)")
        
        catCollectionn.register(UINib(nibName: "\(placeHolderCollectionCell.self)", bundle: nil), forCellWithReuseIdentifier: "\(placeHolderCollectionCell.self)")
        
    }
    
    private func searchDelegate() {
        
        searchController.loadViewIfNeeded()
        searchController.searchResultsUpdater = self
        searchController.searchBar.delegate = self
        searchController.obscuresBackgroundDuringPresentation = false
        searchController.searchBar.enablesReturnKeyAutomatically = false
        searchController.searchBar.returnKeyType = UIReturnKeyType.done
        self.navigationItem.searchController = searchController
        self.navigationItem.hidesSearchBarWhenScrolling = false
        definesPresentationContext = true
        searchController.searchBar.placeholder = "Search for Products"
        searchController.searchBar.searchTextField.textColor = .lightGray
        searchController.searchBar.searchTextField.leftView?.tintColor = .darkGray
        searchController.searchBar.searchTextField.layer.borderWidth = 0.7
        searchController.searchBar.searchTextField.layer.borderColor = CGColor.init(gray: 0.7, alpha: 0.3)
        searchController.searchBar.searchTextField.layer.cornerRadius = 6

        
        
        searchVM.delegate = self
        searchBar?.delegate = self
    }
    
    private func filteredForSearchText(_ searchText: String) {
        if isSearchBarEmpty {
            
        } else {
            filteredProducts = searchVM.allProducts.filter({ Product in
                Product.title!.lowercased().contains(searchText.lowercased())
            })
        }
        catCollectionn.reloadData()
    }
     
}


extension CategoriesController:UISearchResultsUpdating {
    func updateSearchResults(for searchController: UISearchController) {
        guard let searchText = searchBar?.text else { return }
        filteredForSearchText(searchText)
    }
}






extension CategoriesController: UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {

        
        if isSearchBarEmpty {
            
            return searchVM.allProducts.count
        }else {
//            return filteredProducts.count
            
            return filteredProducts.isEmpty ? 1 : filteredProducts.count
        }
        
    }
    
    
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
     
//        guard let cell = catCollectionn.dequeueReusableCell(withReuseIdentifier: "\(CategoryCell.self)", for: indexPath) as? CategoryCell else { return UICollectionViewCell() }


        
        if isSearchBarEmpty {
            guard let cell = catCollectionn.dequeueReusableCell(withReuseIdentifier: "\(CategoryCell.self)", for: indexPath) as? CategoryCell else { return UICollectionViewCell() }
            cell.configure(data: searchVM.allProducts[indexPath.item])
            return cell
        } else {
            
//            cell.configure(data: filteredProducts[indexPath.row])
            
            if filteredProducts.isEmpty {
                guard let placeholderCell = collectionView.dequeueReusableCell(withReuseIdentifier: "\(placeHolderCollectionCell.self)", for: indexPath) as? placeHolderCollectionCell else { return  UICollectionViewCell() }
                           return placeholderCell
            }else {
                guard let cell = catCollectionn.dequeueReusableCell(withReuseIdentifier: "\(CategoryCell.self)", for: indexPath) as? CategoryCell else { return UICollectionViewCell() }
                let data = filteredProducts[indexPath.item]
//                cell.configure(data: filteredProducts[indexPath.item])
                cell.configure(data: data)
                return cell
            }
            
        }
        
        
    }
    
    
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        
        if  (catCollectionn == collectionView )  {


            
            
            let collectionViewWidth = collectionView.frame.width
            let itemWidth = (collectionViewWidth - 3 * cellSpacing) / 2
            
            return CGSize(width: itemWidth, height: itemWidth)

        }
        
        else {
            
            return collectionView.contentSize
        }
        
    }
    
    
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        let selectedPro = productsviewModel.seeAllProducts[indexPath.item].id
        let controller = self.storyboard?.instantiateViewController(withIdentifier: "DetailController") as! DetailController
        controller.productID = selectedPro
        
        self.navigationController?.pushViewController(controller, animated: true)
        
        
    }
    

    
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        searching = false
        searchedData.removeAll()
        catCollectionn.reloadData()
    }
    
    
    
    
}


extension CategoriesController: SearchViewModelDelegate {
    func didFetchSearchProductsSucc() {
        catCollectionn.reloadData()
    }
    
    func didOccurError(_ error: Error) {
        print(error.localizedDescription)
    }
    

    
        
    

    
}

