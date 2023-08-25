//
//  GlobalFunctions.swift
//  Muezzin
//
//  Created by Mohamed Ali Boutaleb on 8/24/23.
//

import CoreLocation

func reverseGeocode(for type: ReverseGeocodeType, location: CLLocation, completion: @escaping (String) -> Void) {
    let geocoder = CLGeocoder()
    
    switch type {
    case .city:
        geocoder.reverseGeocodeLocation(location) { (placemarks, error) in
            var str = ""
            
            if let error = error {
                print("Error reverse geocoding: \(error)")
                completion(str)  // Return an empty array on error.
                return
            }
            
            if let placemark = placemarks?.first {
                if let city = placemark.locality, let state = placemark.administrativeArea {
                    str = "\(city), \(state)"
                }
            }
            completion(str)
        }
        
    case .timezone:
        geocoder.reverseGeocodeLocation(location) { (placemarks, error) in
            var str = ""
            
            if let error = error {
                print("Error reverse geocoding: \(error)")
                completion(str)  // Return an empty array on error.
                return
            }
            
            if let placemark = placemarks?.first {
                if let timeZone = placemark.timeZone {
                    str = timeZone.identifier
                }
            }
            completion(str)
        }
    }
}
