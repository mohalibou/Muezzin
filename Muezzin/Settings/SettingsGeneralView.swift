//
//  SettingsGeneralView.swift
//  Muezzin
//
//  Created by Mohamed Ali Boutaleb on 8/25/23.
//

import SwiftUI

struct SettingsGeneralView: View {
    
    @State private var flag2 = "time"
    @State private var flag3 = "full"
    
    @StateObject private var settings = AppSettings.shared
    
    var body: some View {
        Form {
            Section {
                Toggle("Start Muezzin at login", isOn: settings.$startAtLogin)
                Toggle("Display icon in menu bar", isOn: settings.$displayIcon)
                    .onChange(of: settings.displayIcon) {
                        if !settings.displayIcon && !settings.displayNextPrayer {
                            settings.displayNextPrayer.toggle()
                        }
                    }
                Toggle("Display next prayer in menu bar", isOn: settings.$displayNextPrayer)
                    .onChange(of: settings.displayNextPrayer) {
                        if !settings.displayIcon && !settings.displayNextPrayer {
                            settings.displayIcon.toggle()
                        }
                    }
            }
            
            Section {
                Picker("Prayer time", selection: $flag2) {
                    Text("Time of next prayer").tag("time")
                    Text("Countdown to next prayer").tag("countdown")
                    Text("None").tag("none")
                }
                Picker("Prayer name", selection: $flag3) {
                    Text("Full name").tag("full")
                    Text("Abbreviation").tag("abbreviation")
                    Text("None").tag("none")
                }
            }
        }
        .formStyle(.grouped)
    }
}

#Preview {
    SettingsGeneralView()
}
