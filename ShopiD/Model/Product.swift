//
//  Model.swift
//  ShopiD
//
//  Created by Dogukaim on 8.09.2023.
//

import Foundation



//MARK: Product

struct Product: Codable {
    
    let id: Int?
    let title: String?
    let price: Double?
    let productDescription: String?
    let category: Category?
    let image: String?
    let rating: Rating?
    
    enum CodingKeys: String, CodingKey {
        case id, title, price
        case productDescription = "description"
        case category, image, rating
        
    }
    
}
    
    
    
    
    
enum Category: String, Codable {
    case electronics = "electronics"
    case jewelery = "jewelery"
    case menSClothing = "men's clothing"
    case womenSClothing = "women's clothing"
}
    
// MARK: - Rating
struct Rating: Codable {
    let rate: Double?
    let count: Int?
}





