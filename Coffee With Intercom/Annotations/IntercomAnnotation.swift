//
//  IntercomAnnotation.swift
//  Coffee With Intercom
//
//  Created by Kalpesh Talkar on 21/01/20.
//  Copyright © 2020 Kalpesh. All rights reserved.
//

import MapKit

class IntercomAnnotation: NSObject, MKAnnotation {
    
    static let identifier = String(describing: IntercomAnnotation.self)

    var coordinate: CLLocationCoordinate2D
    var title: String?
    var subtitle: String?
    var image = UIImage(named: "intercom")
    
    override init() {
        title = "Intercom"
        subtitle = "Dublin, Ireland"
        coordinate = CLLocationCoordinate2D(latitude: IntercomDublinLocation.coordinate.latitude, longitude: IntercomDublinLocation.coordinate.longitude)
        super.init()
    }
    
}
