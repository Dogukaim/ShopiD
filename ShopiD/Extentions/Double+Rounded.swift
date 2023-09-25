//
//  Double+Rounded.swift
//  ShopiD
//
//  Created by Dogukaim on 25.09.2023.
//



import Foundation

extension Double {
    func rounded(toPlaces places:Int) -> Double {
        let divisor = pow(10.0, Double(places))
        return (self * divisor).rounded() / divisor
    }
}
