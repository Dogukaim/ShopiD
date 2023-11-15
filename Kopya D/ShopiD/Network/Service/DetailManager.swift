//
//  DetailManager.swift
//  ShopiD
//
//  Created by Dogukaim on 14.11.2023.
//

import Foundation

class DetailManager {
    
    static let shared = DetailManager()
 
    
    
    func getDetail(ID: Int, complete: @escaping((Product?, String?)->())) {
        
        let url = SingleProductWebEndPoint.fetchSingleProducts(id: ID)
        
        } onError: { <#Alamofire.AFError#> in
            <#code#>
        }

}
