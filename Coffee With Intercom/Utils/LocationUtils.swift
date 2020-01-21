//
//  LocationUtils.swift
//  Coffee With Intercom
//
//  Created by Kalpesh Talkar on 21/01/20.
//  Copyright © 2020 Kalpesh. All rights reserved.
//

import Foundation
import CoreLocation

class LocationUtils {
    
    func distanceBetween() {
        
    }
    
}

let IntercomDublinLocation = CLLocation(latitude: 53.339428, longitude: -6.257664)

extension CLLocation {

    func isWithin100KmsFromDublinOffice() -> Bool {
        let distanceInMeters = distance(from: IntercomDublinLocation)
        let distanceInKm = distanceInMeters / 1000
        return distanceInKm <= 100
    }
    
}
