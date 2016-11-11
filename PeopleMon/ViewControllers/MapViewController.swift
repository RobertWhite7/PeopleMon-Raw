//
//  MapViewController.swift
//  PeopleMon
//
//  Created by Robert White on 11/11/16.
//  Copyright © 2016 Teky. All rights reserved.
//

import UIKit
import MapKit
class MapViewController: UIViewController, CLLocationManagerDelegate {
    @IBOutlet weak var theMap: MKMapView!
    
    var locationManager: CLLocationManager!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if (CLLocationManager.locationServicesEnabled()){
            locationManager = CLLocationManager()
            locationManager.delegate = self
            locationManager.desiredAccuracy = kCLLocationAccuracyBest
            locationManager.requestAlwaysAuthorization()
            locationManager.startUpdatingLocation()
        }
    }
    
    private func locationManager(manager: CLLocationManager!, didUpdateLocations locations: [AnyObject]!) {
        let location = locations.last as! CLLocation
        
        let center = CLLocationCoordinate2D(latitude: location.coordinate.latitude, longitude: location.coordinate.longitude)
        
        let region = MKCoordinateRegion(center: center, span: MKCoordinateSpan(latitudeDelta: 0.01, longitudeDelta: 0.01))
        
        self.theMap.setRegion(region, animated: true)
    }
}
/*

class MapViewController: UIViewController {
    @IBOutlet weak var mapView: MKMapView!
    @IBOutlet weak var tableView: UITableView!
 
    
    
    let locationManager = CLLocationManager()
    var updatingLocation = true
    let latitudeDelta = 0.2
    let longitudeDelta = 0.2
    
    var search: MKLocalSearch!
    let searchController = UISearchController(searchResultsController: nil)
    var searchResults: [MKMapItem] = []
    
 
    let transitionManager = TransitionManager()
    
    var overlay: MKOverlay?
    var route: MKRoute?
    
    var directionsView: UIView!
    var directionsTableView: UITableView!
    var showingDirections = false
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        locationManager.delegate = self
        locationManager.requestWhenInUseAuthorization()
        locationManager.distanceFilter = kCLDistanceFilterNone
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        
        mapView.showsUserLocation = true
        locationManager.startUpdatingLocation()
        
 
        
        tableView.isHidden = true
        
        mapView.delegate = self
        definesPresentationContext = true
        
        navigationController?.delegate = self
        
    
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // MARK: - IBAction
    
    @IBAction func updateLocation(_ sender: AnyObject) {
        if !updatingLocation {
            locationManager.startUpdatingLocation()
        }
    }
    

    
    @IBAction func hideDirectionsList(_ sender: AnyObject) {
        UIView.animate(withDuration: 0.5, delay: 0.0, usingSpringWithDamping: 0.7, initialSpringVelocity: 0.8, options: [], animations: {
            self.directionsView.alpha = 0.0
            self.directionsView.transform = CGAffineTransform(scaleX: 0.8, y: 0.8).concatenating(CGAffineTransform(translationX: 0, y: UIScreen.main.bounds.height))
        }) { (finished) in
            self.showingDirections = false
        }
    }
    
    
    // MARK: - Private Functions


    
 

    

}


// MARK: - CLLocationManagerDelegate
extension MapViewController: CLLocationManagerDelegate {
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        let location = locations.last!
        let center = CLLocationCoordinate2D(latitude: location.coordinate.latitude, longitude: location.coordinate.longitude)
        let region = MKCoordinateRegion(center: center, span: MKCoordinateSpanMake(latitudeDelta, longitudeDelta))
        mapView.setRegion(region, animated: true)
        updatingLocation = false
        locationManager.stopUpdatingLocation()
    }
}





// MARK: - UITableView Delegate/Datasource
extension MapViewController: UITableViewDelegate, UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        //      return searchResults.count
        return showingDirections ? route!.steps.count : searchResults.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if showingDirections{
            let cell = UITableViewCell(style: .default, reuseIdentifier: "directionCell")
            
            cell.textLabel?.numberOfLines = 0
            cell.textLabel?.font = UIFont.systemFont(ofSize: 14)
            cell.textLabel?.text = route!.steps[indexPath.row].instructions
            
            return cell
            
        }else{
            let cell = UITableViewCell(style: .subtitle, reuseIdentifier: "searchCell")
            let place = searchResults[indexPath.row]
            
            
            cell.textLabel?.text = place.name
            
            
            return cell
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if !showingDirections{
            tableView.deselectRow(at: indexPath, animated: true)
            let place = searchResults[indexPath.row]
            searchResults = [place]
            
            if let search = search, search.isSearching {
                search.cancel()
            }
            
            searchController.searchBar.resignFirstResponder()
            mapView.selectAnnotation(annotations.first!, animated: false)
            tableView.isHidden = true
        }
    }
    
}


// MARK: - MKMapViewDelegate
extension MapViewController: MKMapViewDelegate {
    func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {
        if annotation is MKUserLocation {
            return nil
        }
        
        let reuseId = "pin"
        var pinView = mapView.dequeueReusableAnnotationView(withIdentifier: reuseId) as? MKPinAnnotationView
        if pinView == nil {
            pinView = MKPinAnnotationView(annotation: annotation, reuseIdentifier: reuseId)
            pinView!.canShowCallout = true
            pinView!.animatesDrop = true
            
            let leftButton = UIButton(frame: CGRect(x: 0, y: 0, width: 25, height: 25))
            leftButton.setImage(#imageLiteral(resourceName: "info"), for: .normal)
            pinView!.leftCalloutAccessoryView = leftButton
            
            let rightButton = UIButton(frame: CGRect(x: 0, y: 0, width: 25, height: 25))
            rightButton.setImage(#imageLiteral(resourceName: "directions"), for: .normal)
            pinView!.rightCalloutAccessoryView = rightButton
            
            if let mapPin = annotation as? MapPin {
                let addressLabel = UILabel()
                addressLabel.numberOfLines = 0
                addressLabel.font = UIFont.systemFont(ofSize: 12)
                addressLabel.text = mapPin.subtitle
                addressLabel.sizeToFit()
                addressLabel.preferredMaxLayoutWidth = 240
                
                var labels = [addressLabel]
                
                if let phone = mapPin.phone {
                    let phoneLabel = UILabel()
                    phoneLabel.font = UIFont.systemFont(ofSize: 12)
                    phoneLabel.text = phone
                    labels.append(phoneLabel)
                }
                
                let stackView = UIStackView(arrangedSubviews: labels)
                stackView.axis = .vertical
                stackView.alignment = .leading
                stackView.distribution = .equalSpacing
                stackView.spacing = 4
                
                pinView!.detailCalloutAccessoryView = stackView
                
                pinView!.leftCalloutAccessoryView!.tag = 0
                pinView!.leftCalloutAccessoryView!.tag = 1
            }
            
        } else {
            pinView!.annotation = annotation
        }
        
        return pinView
    }
    
    func mapView(_ mapView: MKMapView, annotationView view: MKAnnotationView, calloutAccessoryControlTapped control: UIControl) {
        if control.tag == 0 {
         /*  if let mapPin = view.annotation as? MapPin {
                let mapDetailVC = storyboard!.instantiateViewController(withIdentifier: String(describing: MapDetailViewController.self)) as! MapDetailViewController
                
                mapDetailVC.region = mapView.region
                
                mapDetailVC.mapPin = mapPin
                navigationController?.pushViewController(mapDetailVC, animated: true)
            } */
        }else if control.tag == 1 {
            if let coordinate = view.annotation?.coordinate {
                let request = MKDirectionsRequest()
                mapView.deselectAnnotation(view.annotation, animated: true)
                request.source = MKMapItem.forCurrentLocation()
                request.destination = MKMapItem(placemark: MKPlacemark(coordinate: coordinate))
                
                let directions = MKDirections(request: request)
                directions.calculate(completionHandler: { (respones, error) in
                    guard let response = respones else{
                        return
                    }
                 
                })
            }
        }
    }
    
    func mapView(_ mapView: MKMapView, rendererFor overlay: MKOverlay) ->
        MKOverlayRenderer {
            self.overlay = overlay
            let renderer = MKPolylineRenderer(overlay: overlay)
            renderer.strokeColor = #colorLiteral(red: 0.2196078449, green: 0.007843137719, blue: 0.8549019694, alpha: 1)
            renderer.lineWidth = 5.0
            renderer.lineCap = .round
            return renderer
    }
}

//MARK: - UINavigationControllerDelegate
extension MapViewController: UINavigationControllerDelegate {
    func navigationController(_ navigationController: UINavigationController, animationControllerFor operation: UINavigationControllerOperation, from fromVC: UIViewController, to toVC: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        transitionManager.reverse = operation == .pop
        return transitionManager
    }
} */
/*

class MapViewController : UIViewController, CLLocationManagerDelegate {
    
    @IBOutlet weak var map: MKMapView!
    var locationManager: CLLocationManager!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if (CLLocationManager.locationServicesEnabled())
        {
            locationManager = CLLocationManager()
            locationManager.delegate = self
            locationManager.desiredAccuracy = kCLLocationAccuracyBest
            locationManager.requestAlwaysAuthorization()
            locationManager.startUpdatingLocation()
        }
        
    }
    private func locationManager(manager: CLLocationManager!, didUpdateLocations locations: [AnyObject]!) {
        let location = locations.last as! CLLocation
        
        let center = CLLocationCoordinate2D(latitude: location.coordinate.latitude, longitude: location.coordinate.longitude)
        let region = MKCoordinateRegion(center: center, span: MKCoordinateSpan(latitudeDelta: 0.01, longitudeDelta: 0.01))
        
        self.map.setRegion(region, animated: true)
    }
}*/
