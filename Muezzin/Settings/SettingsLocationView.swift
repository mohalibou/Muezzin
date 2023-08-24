//
//  SettingsLocationView.swift
//  Muezzin
//
//  Created by Mohamed Ali Boutaleb on 8/17/23.
//

import CoreLocation
import MapKit
import SwiftUI

struct SettingsLocationView: View {
    
    @State private var flag = true
    @State private var timeZone = TimeZone.current.identifier
    @State private var location: CLLocationCoordinate2D? = nil
    
    @StateObject private var locationManager = LocationManager()
    
    var sortedTimeZoneIdentifiers: [String] {
        TimeZone.knownTimeZoneIdentifiers.sorted {
            formatTimeZoneIdentifier($0) < formatTimeZoneIdentifier($1)
        }
    }
    
    var body: some View {
        Form {
            Section {
                Toggle("Use current location", isOn: $flag)
            } footer: {
                
                
                Spacer()
            }
            
            Section("Prayer times location") {
                MLocationMap(disabled: $flag, location: $location, timeZone: $timeZone)
                
                Picker("Time zone", selection: $timeZone) {
                    ForEach(sortedTimeZoneIdentifiers, id: \.self) { timeZoneIdentifier in
                        Text(formatTimeZoneIdentifier(timeZoneIdentifier)).tag(timeZoneIdentifier)
                    }
                }
            }
            .disabled(flag)
        }
        .formStyle(.grouped)
    }
    
    var locationFooter: some View {
        Group {
            
        }
        
    }
    
    func formatTimeZoneIdentifier(_ identifier: String) -> String {
        let components = identifier.split(separator: "/")
        return components.last?.replacingOccurrences(of: "_", with: " ") ?? identifier
    }
}
