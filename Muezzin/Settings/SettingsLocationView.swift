//
//  SettingsLocationView.swift
//  Muezzin
//
//  Created by Mohamed Ali Boutaleb on 8/25/23.
//

import CoreLocation
import SwiftUI

struct SettingsLocationView: View {
    
    @StateObject private var settings = AppSettings.shared

    @State private var useCurrentLocation = false
    
    var body: some View {
        Form {
            Section {
                Toggle("Use current location", isOn: $useCurrentLocation)
            }
            
            Section("Prayer times location") {
                MLocationMap(disabled: $useCurrentLocation, latitude: settings.$customLocationLatitude, longitude: settings.$customLocationLongitude, timeZone: settings.$customTimeZone)
                MTimeZonePicker(timeZone: settings.$customTimeZone)
            }
            .disabled(useCurrentLocation)
        }
        .formStyle(.grouped)
    }
}
