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
    var readFromRemoteTextFile = false
    var customers = [Customer]()
    let locationUtils = LocationUtils()

    // MARK: - Life cycle methods
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupMap()
        if readFromRemoteTextFile {
            let hud = MBProgressHUD.showAdded(to: view, animated: true)
            hud.label.text = "Reading customers..."
            fileReader.readCustomersFromRemoteFile { (customers) in
                hud.hide(animated: true)
                self.customers = customers
                self.showCustomersOnMap()
            }
        } else {
            fileReader.readCustomersFromBundle { (customers) in
                self.customers = customers
                self.showCustomersOnMap()
            }
        }
    }
    
    private func setupMap() {
        mapView.delegate = self
        mapView.addAnnotation(IntercomAnnotation())
        mapView.setCenter(IntercomDublinLocation.coordinate, animated: true)
        let circle = MKCircle(center: IntercomDublinLocation.coordinate, radius: 100000 as CLLocationDistance) // 100000 m = 100 km
        mapView.addOverlay(circle)
        recenterMap()
    }
    
    private func showCustomersOnMap() {
        let annotations = customers.map { (customer) -> CustomerAnnotation in
            return CustomerAnnotation(customer: customer)
        }
        mapView.addAnnotations(annotations)
    }
    
    // MARK: - IBActions
    
    @IBAction private func recenterMap() {
        var region = MKCoordinateRegion()
        region.center = IntercomDublinLocation.coordinate
        region.span.latitudeDelta = 3.5
        region.span.longitudeDelta = 4
        let adjustedRegion = mapView.regionThatFits(region)
        mapView.setRegion(adjustedRegion, animated: true)
    }
    
    @IBAction private func showCustomerList() {
        if let customerListVC = Storyboard.Main.viewController(of: CustomersVC.self) {
            // Filter customers in 100 km range and sorted by user id in the ascending order.
            customerListVC.customers = customers.filter({ (customer) -> Bool in
                return locationUtils.isWithin100KmFromDublinOffice(latitude: customer.latitude, longitude: customer.longitude)
            }).sorted(by: { $0.userId < $1.userId  })
            present(customerListVC, animated: true, completion: nil)
        }
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
