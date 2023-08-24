//
//  SettingsGeneralView.swift
//  Muezzin
//
//  Created by Mohamed Ali Boutaleb on 8/17/23.
//

import SwiftUI

struct SettingsGeneralView: View {
    
    @StateObject private var settings = AppSettings.shared
    
    @State private var flag = true
    @State private var flag2 = "time"
    @State private var flag3 = "full"
    @State private var flag4 = false
    @State private var flag5 = true
    
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
            .disabled(!flag)
        }
        .formStyle(.grouped)
    }
}

