//
//  GlobalFunctions.swift
//  Muezzin
//
//  Created by Mohamed Ali Boutaleb on 8/24/23.
//

import CoreLocation

func reverseGeocode(_ location: CLLocation, completion: @escaping ([String]) -> Void) {
    let geocoder = CLGeocoder()

    geocoder.reverseGeocodeLocation(location) { (placemarks, error) in
        var array: [String] = []

        if let error = error {
            print("Error reverse geocoding: \(error)")
            completion(array)  // Return an empty array on error.
            return
        }

        if let placemark = placemarks?.first {
            if let city = placemark.locality, let state = placemark.administrativeArea {
                array = [city, state]
            }
        }
        completion(array)
    }
}
