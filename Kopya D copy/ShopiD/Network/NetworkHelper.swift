//
//  NetworkHelper.swift
//  ShopiD
//
//  Created by Dogukaim on 15.09.2023.
//

import Foundation

//MARK: - NetworkEndPoint

enum NetworkEndPoint: String {
    case BASE_URL = "https://fakestoreapi.com"
}

final class NetworkHelper {
    deinit {
        print("deinit networkhelper")
    }
    static let shared = NetworkHelper()

    func requestUrl(url: String) -> String {
        if let url = "\(NetworkEndPoint.BASE_URL.rawValue)\(url)".addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed) {
            return url
        }
        return "https://fakestoreapi.com/products"
    }
}

