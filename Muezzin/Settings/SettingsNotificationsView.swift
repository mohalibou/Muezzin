//
//  SettingsNotificationsView.swift
//  Muezzin
//
//  Created by Mohamed Ali Boutaleb on 8/25/23.
//

import SwiftUI

struct SettingsNotificationsView: View {
    
    @StateObject private var settings = AppSettings.shared

    var body: some View {
        Form {
            Section {
                Toggle("Silent Mode", isOn: settings.$silentMode)
            }
            
            Section {
                MNotificationPicker(name: "Fajr", setting: settings.$fajr)
                MNotificationPicker(name: "Duhr", setting: settings.$duhr)
                MNotificationPicker(name: "Asr", setting: settings.$asr)
                MNotificationPicker(name: "Maghrib", setting: settings.$maghrib)
                MNotificationPicker(name: "Isha", setting: settings.$isha)
            }
            .disabled(settings.silentMode)
            
            Section {
                Toggle("Play Dua After Athan", isOn: settings.$playDuaAfterAthan)
            }
            .disabled(settings.silentMode)
            
            Section {
                HStack {
                    LabeledContent("Notifications") {
                        Button("Configure in System Settings") {}
                    }
                }
            }
        }
        .formStyle(.grouped)
    }
}
