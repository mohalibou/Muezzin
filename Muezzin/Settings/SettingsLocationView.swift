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
    
    @State private var flag = false
    
    @State private var location: CLLocationCoordinate2D?
    

    
    var body: some View {
        Form {
            Section {
                Toggle("Use current location", isOn: $flag)
            }
            
            Section("Prayer times location") {
                MLocationMap(disabled: $flag, location: $location, timeZone: settings.$customTimeZone)
                MTimeZonePicker(timeZone: settings.$customTimeZone)
            }
            .disabled(flag)
        }
        .formStyle(.grouped)
    }
}

#Preview {
    SettingsLocationView()
}
