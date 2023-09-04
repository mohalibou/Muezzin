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
                Toggle("Silent mode", isOn: settings.$silentMode)
            }
            Section {
                MNotificationPicker(name: "Fajr", selection: settings.$fajrAthan, audioPlayer: fajrPlayer, allAudioPlayers: allPlayers)
                MNotificationPicker(name: "Duhr", selection: settings.$duhrAthan, audioPlayer: duhrPlayer, allAudioPlayers: allPlayers)
                MNotificationPicker(name: "Asr", selection: settings.$asrAthan, audioPlayer: asrPlayer, allAudioPlayers: allPlayers)
                MNotificationPicker(name: "Maghrib", selection: settings.$maghribAthan, audioPlayer: maghribPlayer, allAudioPlayers: allPlayers)
                MNotificationPicker(name: "Isha", selection: settings.$ishaAthan, audioPlayer: ishaPlayer, allAudioPlayers: allPlayers)
            }
            Section {
                Toggle("Play Dua After Athan", isOn: settings.$playDuaAfterAthan)
            }
            Section {
                LabeledContent("Notifications") {
                    Button("Configure in System Settings") {}
                }
            }
        }
        .formStyle(.grouped)
    }
}

#Preview {
    SettingsNotificationsView()
}
