//
//  Model.swift
//  ShopiD
//
//  Created by Dogukaim on 8.09.2023.
//

import Foundation



//MARK: Product

struct Product: Codable,TopProtocolViewCell,ThirdProtocolViewCell,SeeProtocolViewCell,ProductsProtocolCell,CategorysProtocolCell {
    
    
  
    
    
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
    
    
    //MARK: - TopProtocolViewCell
    
    var topimage: String {
        if let image = image {
            return image
        }
        return ""
    }
    
    var topname: String {
        if let title = title {
            return title
        }
        return ""
    }
    
    var topPrice: String {
        if let price = price {
            return "$\(price)"
        }
        return ""
    }
    
    
    
    
    //MARK: - ThirdProtocolViewCell
    
    var thirdimage: String {
        if let image = image {
            return image
        }
        return ""
    }
    
    var thirdname: String {
        if let title = title {
            return title
        }
        return ""
    }
    
    var thirdprice: String {
        if let price = price {
            return "$\(price)"
        }
        return ""
    }
    
    
    
    
    //MARK: - SeeProtocolViewCell
    
    
    var proimage: String {
        if let image = image {
            return image
        }
        return ""
    }
    
    var proname: String {
        if let title = title {
            return title
        }
        return ""
    }
    
    var proprice: String {
        if let price = price {
            return "$\(price)"
        }
        return ""
    }
    

    
    //MARK: ProductsProtocolCell
    
    var produimage: String {
        if let image = image {
            return image
        }
        return ""
    }
    
    var produname: String {
        if let title = title {
            return title
        }
        return ""
    }
    
    var produprice: String {
        if let price = price {
            return "$\(price)"
        }
        return ""
    }
    
    var produsold: String {
        if let sold = rating?.count {
            return "\(sold) sold"
        }
        return ""
    }
    
    var produrati: String {
        if let rate = rating?.rate {
            return "\(rate)"
        }
        return ""
    }
    
    
    
    //MARK: -CategorysProtocolCell
    
    var catproimage: String {
        if let image = image {
            return image
        }
        return ""
    }
    
    var catproduname: String {
        if let title = title {
            return title
        }
        return ""
    }
    
    var catproduprice: String {
        if let price = price {
            return "$\(price)"
        }
        return ""
    }
    
    var catprodusold: String {
        if let sold = rating?.count {
            return "\(sold) sold"
        }
        return ""
    }
    
    var catprodurati: String {
        if let rate = rating?.rate {
            return "\(rate)"
        }
        return ""
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





