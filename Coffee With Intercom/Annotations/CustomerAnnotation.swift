//
//  CustomerAnnotation.swift
//  Coffee With Intercom
//
//  Created by Kalpesh Talkar on 21/01/20.
//  Copyright © 2020 Kalpesh. All rights reserved.
//

import MapKit

class CustomerAnnotation: NSObject, MKAnnotation {
    
    static let identifier = String(describing: CustomerAnnotation.self)

    var coordinate: CLLocationCoordinate2D
    var title: String?
    var subtitle: String?
    var image = UIImage(named: "person_pin")
    let customer: Customer
    
    init(customer: Customer) {
        self.customer = customer
        title = customer.name
        subtitle = "Id: \(customer.userId)"
        self.coordinate = CLLocationCoordinate2D(latitude: customer.latitude, longitude: customer.longitude)
        if CLLocation(latitude: customer.latitude, longitude: customer.longitude).isWithin100KmsFromDublinOffice() {
            image = image?.color(color: UIColor.systemGreen.withAlphaComponent(0.7))
        } else {
            image = image?.color(color: UIColor.systemOrange.withAlphaComponent(0.7))
        }
    }
    
}
