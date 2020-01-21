//
//  MapVC.swift
//  Coffee With Intercom
//
//  Created by Kalpesh Talkar on 21/01/20.
//  Copyright © 2020 Kalpesh. All rights reserved.
//

import UIKit
import MapKit
import MBProgressHUD

class MapVC: UIViewController {
    
    // MARK: - IBOutlets and Properties
    
    @IBOutlet private weak var mapView: MKMapView!
    
    let fileReader = FileReader()

    // MARK: - Life cycle methods
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupMap()
        
        let hud = MBProgressHUD.showAdded(to: view, animated: true)
        hud.label.text = "Reading customers..."
        fileReader.readCustomersFromRemoteFile { (customers) in
            hud.hide(animated: true)
            self.showCustomersOnMap(customers: customers)
        }
        
        /*fileReader.readCustomersFromBundle { (customers) in
            self.showCustomersOnMap(customers: customers)
        }*/
    }
    
    private func setupMap() {
        mapView.delegate = self
        mapView.addAnnotation(IntercomAnnotation())
        mapView.setCenter(IntercomDublinLocation.coordinate, animated: true)
        let circle = MKCircle(center: IntercomDublinLocation.coordinate, radius: 100000 as CLLocationDistance) // 100000 m = 100 km
        mapView.addOverlay(circle)
        var region = MKCoordinateRegion()
        region.center = IntercomDublinLocation.coordinate
        region.span.latitudeDelta = 3.5
        region.span.longitudeDelta = 4
        let adjustedRegion = mapView.regionThatFits(region)
        mapView.setRegion(adjustedRegion, animated: true)
    }
    
    private func showCustomersOnMap(customers: [Customer]) {
        let annotations = customers.map { (customer) -> CustomerAnnotation in
            return CustomerAnnotation(customer: customer)
        }
        mapView.addAnnotations(annotations)
    }

}

extension MapVC: MKMapViewDelegate {
    
    func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {
        if let intercomAnnotation = annotation as? IntercomAnnotation {
            let annotationView = MKAnnotationView(annotation: annotation, reuseIdentifier: nil)
            annotationView.annotation = annotation
            annotationView.image = intercomAnnotation.image
            annotationView.canShowCallout = true
            return annotationView
        }
        if let customerAnnotation = annotation as? CustomerAnnotation {
            var annotationView = mapView.dequeueReusableAnnotationView(withIdentifier: CustomerAnnotation.identifier)
            if annotationView == nil {
                annotationView = MKAnnotationView(annotation: annotation, reuseIdentifier: CustomerAnnotation.identifier)
            } else {
                annotationView?.annotation = annotation
            }
            annotationView?.canShowCallout = true
            annotationView?.image = customerAnnotation.image
            annotationView?.tintColor = .systemGreen
            return annotationView
        }
        return nil
    }
    
    func mapView(_ mapView: MKMapView, rendererFor overlay: MKOverlay) -> MKOverlayRenderer {
        if overlay is MKCircle {
            let circle = MKCircleRenderer(overlay: overlay)
            circle.strokeColor = UIColor.systemBlue
            circle.fillColor = UIColor.systemBlue.withAlphaComponent(0.2)
            circle.lineWidth = 0.5
            return circle
        }
        return MKOverlayRenderer()
    }
    
}
