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
    
    var body: some View {
        Form {
            Section {
                Toggle("Use current location", isOn: $flag)
            }
            
            Section("Prayer times location") {
                MLocationMap(disabled: $flag)
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
