//
//  Customer.swift
//  Coffee With Intercom
//
//  Created by Kalpesh Talkar on 21/01/20.
//  Copyright © 2020 Kalpesh. All rights reserved.
//

import Foundation
import MapKit

struct Customer: Codable {
    
    let userId: Int
    let name: String
    let latitude: Double
    let longitude: Double
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        userId = try container.decode(Int.self, forKey: .userId)
        name = try container.decode(String.self, forKey: .name)
        let lat = try container.decode(String.self, forKey: .latitude)
        latitude = Double(lat) ?? 0
        let lng = try container.decode(String.self, forKey: .longitude)
        longitude = Double(lng) ?? 0
    }
    
}

extension Customer {
    
    var coordinate: CLLocation {
        return CLLocation(latitude: latitude, longitude: longitude)
    }
    
}
