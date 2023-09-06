//
//  SettingsGeneralView.swift
//  Muezzin
//
//  Created by Mohamed Ali Boutaleb on 8/25/23.
//

import LaunchAtLogin
import SwiftUI

struct SettingsGeneralView: View {
    
    @StateObject private var settings = AppSettings.shared
    
    
    var body: some View {
        Form {
            Section {
                LaunchAtLogin.Toggle("Start Muezzin at login")
                //Toggle("Start Muezzin at login", isOn: settings.$startAtLogin)
                
                Toggle("Display icon in menu bar", isOn: settings.$displayIcon)
                    .onChange(of: settings.displayIcon) { toggle(settings.$displayNextPrayer) }
                
                Toggle("Display next prayer in menu bar", isOn: settings.$displayNextPrayer)
                    .onChange(of: settings.displayNextPrayer) { toggle(settings.$displayIcon) }
            }
            
            Section {
                Picker("Prayer name", selection: settings.$prayerName) {
                    Text("Full name").tag(Name.full)
                    Text("Abbreviation").tag(Name.abbreviation)
                    Text("None").tag(Name.none)
                }
                Picker("Prayer time", selection: settings.$prayerTime) {
                    Text("Time of next prayer").tag(Time.time)
                    Text("Countdown to next prayer").tag(Time.countdown)
                    Text("None").tag(Time.none)
                }
            }
            .disabled(!settings.displayNextPrayer)
        }
        .formStyle(.grouped)
    }
    
    private func toggle(_ setting: Binding<Bool>) {
        if !settings.displayIcon && !settings.displayNextPrayer {
            setting.wrappedValue = true
        }
    }
}
