//
//  MLocationMap.swift
//  Muezzin
//
//  Created by Mohamed Ali Boutaleb on 8/25/23.
//

import CoreLocation
import MapKit
import SwiftUI

struct MLocationMap: View {
    
    @StateObject var settings = AppSettings.shared
    
    @Binding var disabled: Bool
    
    @State private var location: CLLocationCoordinate2D?
    @State var locationName: String = "N/A"
    
    var region: MKCoordinateRegion {
        MKCoordinateRegion(center: CLLocationCoordinate2D(latitude: settings.customLocationLatitude ?? 25,
                                                          longitude: settings.customLocationLongitude ?? 46),
                           span: MKCoordinateSpan(latitudeDelta: 30,
                                                  longitudeDelta: 30))
        
    }
    
    
    var body: some View {
        ZStack {
            MapReader { reader in
                Map(initialPosition: .region(region)) {
                    if let location {
                        Marker("(\(location.latitude), \(location.longitude))", coordinate: location)
                    }
                }
                .overlay(Color.black.opacity(disabled ? 0.6 : 0))
                .cornerRadius(5)
                .mapControlVisibility(.hidden)
                .onTapGesture { coords in
                    let coordinates = CGPoint(x: coords.x, y: coords.y - 125)
                    location = reader.convert(coordinates, from: .local)
                    getLocationNameAndSetTimeZone()
                    settings.customLocationLatitude = location?.latitude
                    settings.customLocationLongitude = location?.longitude
                }
            }
            
            VStack {
                HStack {
                    locationMessage
                        .padding(8)
                    Spacer()
                }
                Spacer()
            }
            
            
            if disabled {
                disabledMessage
            }
        }
        .frame(height: 250)
        .onAppear {
            if let customLocationLatitude = settings.customLocationLatitude,
                let customLocationLongitude = settings.customLocationLongitude {
                location = CLLocationCoordinate2D(latitude: customLocationLatitude,
                                                  longitude: customLocationLongitude)
                getLocationNameAndSetTimeZone()
            }
            
        }
    }
    
    var disabledMessage: some View {
        Text("Disable \"Use current location\" to\nmanually set a location.")
            .multilineTextAlignment(.center)
            .padding(8)
            .background {
                RoundedRectangle(cornerRadius: 5)
                    .strokeBorder(Color(nsColor: .quaternaryLabelColor), lineWidth: 1)
                    .background(RoundedRectangle(cornerRadius: 5).fill(Color(nsColor: .windowBackgroundColor)))
            }
    }
    
    var locationMessage: some View {
        Text("Location: \(locationName)")
            .padding(8)
            .overlay(Color.black.opacity(disabled ? 0.6 : 0))
            .background {
                RoundedRectangle(cornerRadius: 5)
                    .strokeBorder(Color(nsColor: .quaternaryLabelColor), lineWidth: 1)
                    .background(RoundedRectangle(cornerRadius: 5).fill(Color(nsColor: .windowBackgroundColor)))
            }
    }
    
    private func getLocationNameAndSetTimeZone() {
        let locationToGeocode = CLLocation(latitude: location?.latitude ?? 0, longitude: location?.longitude ?? 0)
        let geocoder = CLGeocoder()
        geocoder.reverseGeocodeLocation(locationToGeocode) { (placemarks, error) in
            if let placemark = placemarks?.first, let city = placemark.locality, let state = placemark.administrativeArea {
                locationName = city == state ? "\(city)" : "\(city), \(state)"
            } else if let placemark = placemarks?.first, let state = placemark.administrativeArea {
                locationName = "\(state)"
            } else {
                locationName = "Unknown"
            }
            
            if let placemark = placemarks?.first, let timeZone = placemark.timeZone {
                settings.customTimeZone = timeZone.identifier
            }
        }
    }
    
}
