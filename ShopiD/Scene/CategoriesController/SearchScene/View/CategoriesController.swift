//
//  CategoriesController.swift
//  ShopiD
//
//  Created by Dogukaim on 7.09.2023.
//

import UIKit


class CategoriesController: UIViewController, UISearchBarDelegate {
    
    
    
    @IBOutlet weak var catCollectionn: UICollectionView!
    
    @IBOutlet weak var baritemT: UIBarButtonItem!
    
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
    
    
    
    weak var delegate: SearchViewModelDelegate?
    
    
    
    
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
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        
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
    
    
    @IBAction func filterButtonTap(_ sender: Any) {
        
        
        let controller = storyboard?.instantiateViewController(withIdentifier: "filterCategory") as! filterCategory
        controller.modalPresentationStyle = .overFullScreen
        controller.modalTransitionStyle = .crossDissolve
        present(controller, animated: true, completion: nil)
        print("FilterCategory Pop")
        controller.delegate = self
        
        let newImage = UIImage(systemName: "line.3.horizontal.decrease.circle.fill")
        navigationItem.rightBarButtonItem?.image = newImage
        
        
        
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
            
            return filteredProducts.isEmpty ? 1 : filteredProducts.count
        }
        
    }
    
    
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        
        if isSearchBarEmpty {
            guard let cell = catCollectionn.dequeueReusableCell(withReuseIdentifier: "\(CategoryCell.self)", for: indexPath) as? CategoryCell else { return UICollectionViewCell() }
            cell.configure(data: searchVM.allProducts[indexPath.item])
            return cell
        } else {
            
            
            
            if filteredProducts.isEmpty {
                guard let placeholderCell = collectionView.dequeueReusableCell(withReuseIdentifier: "\(placeHolderCollectionCell.self)", for: indexPath) as? placeHolderCollectionCell else { return  UICollectionViewCell() }
                return placeholderCell
            }else {
                guard let cell = catCollectionn.dequeueReusableCell(withReuseIdentifier: "\(CategoryCell.self)", for: indexPath) as? CategoryCell else { return UICollectionViewCell() }
                let data = filteredProducts[indexPath.item]
                
                cell.configure(data: data)
                return cell
            }
            
        }
        
        
        
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        
        let cellHeight: CGFloat = 250
        let cellWidth: CGFloat
        if isSearchBarEmpty {
            
            cellWidth = collectionView.bounds.width / 2 - 10
        } else {
            
            cellWidth = collectionView.bounds.width - 40
        }
        
        return CGSize(width: cellWidth, height: cellHeight)
    }
    
    
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        var selectedPro = searchVM.allProducts[indexPath.item]
        
        if isSearchBarEmpty {
            selectedPro = searchVM.allProducts[indexPath.item]
        } else {
            if filteredProducts.isEmpty {
                
                return
            } else {
                selectedPro = filteredProducts[indexPath.item]
            }
        }
        
        let controller = self.storyboard?.instantiateViewController(withIdentifier: "DetailController") as! DetailController
        controller.productID = selectedPro.id
        self.navigationController?.pushViewController(controller, animated: true)
        
        
    }
    
    
    
    
    
    
    
}


extension CategoriesController: SearchViewModelDelegate {
    func didSelectAllCategoriess() {
        searchVM.fetchAllProducts()
    }
    
    
    
    func didFetchSearchProductsSucc() {
        catCollectionn.reloadData()
    }
    
    func didOccurError(_ error: Error) {
        print(error.localizedDescription)
    }
    
    func didFetchProductsByCategorySuc() {
        catCollectionn.reloadData()
    }
    
    
    
}


extension CategoriesController: FilterCategoryDelegate {
    
    
    
    
    
    
    func filterCategoryDidDismiss() {
        let originalImage = UIImage(systemName: "line.3.horizontal.decrease.circle")
        self.setBarButtonImage(originalImage)
    }
    
    
    
    
    func setBarButtonImage(_ image: UIImage?) {
        
        baritemT.image = image
    }
    
    func filterCategoryDidDismiss(selectedCategory: String?) {
        
        
        guard let category = selectedCategory, category != "All" else {
            
            searchVM.fetchAllProducts()
            return
        }
        
        
        filterProductsByCategory(category)
        
        
        
    }
    
    
    
    func filterProductsByCategory(_ category: String) {
        searchVM.fetchProductByCategory(category)
    }
    
    
    func didSelectCategory(_ category: String) {
        filterProductsByCategory(category)
        
        print("Selected category: \(category)")
    }
    
    
    
    func didSelectAllCategories() {
        searchVM.fetchAllProducts()

    }
    
    
    
}
