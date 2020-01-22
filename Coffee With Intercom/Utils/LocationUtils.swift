//
//  LocationUtils.swift
//  Coffee With Intercom
//
//  Created by Kalpesh Talkar on 21/01/20.
//  Copyright © 2020 Kalpesh. All rights reserved.
//

import Foundation
import CoreLocation

let IntercomDublinLocation = CLLocation(latitude: 53.339428, longitude: -6.257664)

class LocationUtils {
    
    func isWithin100KmFromDublinOffice(latitude: Double, longitude: Double) -> Bool {
        let distance = distanceBetween(latitude1: latitude, longitude1: longitude, latitude2: IntercomDublinLocation.coordinate.latitude, longitude2: IntercomDublinLocation.coordinate.longitude)
        return distance <= 100
    }
    
    /// Find distance in kilometers between to coordinates using spherical law of cosines.
    ///  Reference: https://en.wikipedia.org/wiki/Great-circle_distance
    /// - Parameters:
    ///   - latitude1: Point 1 latitude.
    ///   - longitude1: Point 1 longitude.
    ///   - latitude2: Point 2 latitude.
    ///   - longitude2: Point 2 longitude.
    func distanceBetween(latitude1: Double, longitude1: Double, latitude2: Double, longitude2: Double) -> Double {
        let radius: Double = 6378.137.toRadians() // earth's radius in km
        
        let lat1Rad = latitude1.toRadians()
        let lng1Rad = longitude1.toRadians()
        let lat2Rad = latitude2.toRadians()
        let lng2Rad = longitude2.toRadians()
        
        let absLngDiff = abs(lng1Rad - lng2Rad)
        
        let centralAngle = acos(sin(lat1Rad) * sin(lat2Rad) + cos(lat1Rad) * cos(lat2Rad) * cos(absLngDiff))
        let distance = radius * centralAngle
        
        return distance.toDegrees() // Distance in km
    }
    
}

extension Double {
    
    func toRadians() -> Double {
        return self * .pi / 180
    }
    
    func toDegrees() -> Double {
        return self * 180 / .pi
    }
    
}

extension CLLocation {

    func isWithin100KmsFromDublinOffice() -> Bool {
        let distanceInMeters = distance(from: IntercomDublinLocation)
        let distanceInKm = distanceInMeters / 1000
        return distanceInKm <= 100
    }
    
}
