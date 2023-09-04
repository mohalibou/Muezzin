//
//  SettingsGeneralView.swift
//  Muezzin
//
//  Created by Mohamed Ali Boutaleb on 8/25/23.
//

import SwiftUI

struct SettingsGeneralView: View {
    
    @StateObject private var settings = AppSettings.shared
    
    var body: some View {
        Form {
            Section {
                Toggle("Start Muezzin at login", isOn: settings.$startAtLogin)
                Toggle("Display icon in menu bar", isOn: settings.$displayIcon)
                Toggle("Display next prayer in menu bar", isOn: settings.$displayNextPrayer)
            }
            
            Section {
                Picker("Prayer time", selection: settings.$prayerTime) {
                    Text("Time of next prayer").tag("time")
                    Text("Countdown to next prayer").tag("countdown")
                    Text("None").tag("none")
                }
                Picker("Prayer name", selection: settings.$prayerName) {
                    Text("Full name").tag("full")
                    Text("Abbreviation").tag("abbreviation")
                    Text("None").tag("none")
                }
            }
        }
        .formStyle(.grouped)
    }
}
