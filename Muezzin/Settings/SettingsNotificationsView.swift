//
//  SettingsNotificationsView.swift
//  Muezzin
//
//  Created by Mohamed Ali Boutaleb on 8/25/23.
//

import SwiftUI

struct SettingsNotificationsView: View {
    
    @StateObject private var settings = AppSettings.shared
    
    @StateObject private var fajrPlayer = AudioPlayer()
    @StateObject private var duhrPlayer = AudioPlayer()
    @StateObject private var asrPlayer = AudioPlayer()
    @StateObject private var maghribPlayer = AudioPlayer()
    @StateObject private var ishaPlayer = AudioPlayer()
    
    var allPlayers: [AudioPlayer] { [fajrPlayer, duhrPlayer, asrPlayer, maghribPlayer, ishaPlayer] }

    var body: some View {
        Form {
            Section {
                Toggle("Silent Mode", isOn: settings.$silentMode)
            }
            
            Section {
                MNotificationPicker(name: "Fajr", setting: settings.$fajr, audioPlayer: fajrPlayer, allPlayers: allPlayers)
                MNotificationPicker(name: "Duhr", setting: settings.$duhr, audioPlayer: duhrPlayer, allPlayers: allPlayers)
                MNotificationPicker(name: "Asr", setting: settings.$asr, audioPlayer: asrPlayer, allPlayers: allPlayers)
                MNotificationPicker(name: "Maghrib", setting: settings.$maghrib, audioPlayer: maghribPlayer, allPlayers: allPlayers)
                MNotificationPicker(name: "Isha", setting: settings.$isha, audioPlayer: ishaPlayer, allPlayers: allPlayers)
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
