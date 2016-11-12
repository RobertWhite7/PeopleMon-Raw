//
//  MapPin.swift
//  PeopleMon
//
//  Created by Robert White on 11/12/16.
//  Copyright © 2016 Teky. All rights reserved.
//

import UIKit
import MapKit

class MapPin: NSObject, MKAnnotation {
    var coordinate: CLLocationCoordinate2D
    var person: Account?
    
    init(person: Account) {
        self.person = person
        if let lat = person.latitude, let long = person.longitude {
            self.coordinate = CLLocationCoordinate2D(latitude: lat, longitude: long)
        } else {
            self.coordinate = CLLocationCoordinate2D(latitude: 0, longitude: 0)
        }
    }
}
