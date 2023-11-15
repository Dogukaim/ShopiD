//
//  NSDate+GetTimeDateFormat.swift
//  ShopiD
//
//  Created by Dogukaim on 15.09.2023.
//

import Foundation


extension NSDate
{
    func getCurrentHour() -> Int {
           let currentDateTime = Date()
        let calendar = NSCalendar.current
        let component = calendar.component(.hour, from: currentDateTime)
           let hour = component
           return hour
       }
    
}
