//
//  SettingsNotificationsView.swift
//  Muezzin
//
//  Created by Mohamed Ali Boutaleb on 8/17/23.
//

import SwiftUI

struct SettingsNotificationsView: View {
    
    @StateObject private var settings = AppSettings.shared
    
    @StateObject private var fajrPlayer = AudioPlayer()
    @StateObject private var duhrPlayer = AudioPlayer()
    @StateObject private var asrPlayer = AudioPlayer()
    @StateObject private var maghribPlayer = AudioPlayer()
    @StateObject private var ishaPlayer = AudioPlayer()
    
    var body: some View {
        Form {
            Section {
                Toggle("Silent Mode", isOn: settings.$silentMode)
            }
            
            Section {
                HStack {
                    Picker("Fajr", selection: settings.$fajr) {
                        Text("None").tag("none")
                        Divider()
                        Text("Alafasy (Fajr)").tag("athan1_fajr")
                        Text("Alafasy").tag("athan1")
                        Text("Mullah").tag("athan2")
                        Text("Al-Qatami").tag("athan3")
                        Text("Güneşdoğdu").tag("athan4")
                    }
                    Button(fajrPlayer.isPlaying ? "Stop" : "Play") {
                        playAthan(settings.fajr, with: fajrPlayer)
                    }
                }
                HStack {
                    Picker("Duhr", selection: settings.$duhr) {
                        Text("None").tag("none")
                        Divider()
                        Text("Alafasy").tag("athan1")
                        Text("Mullah").tag("athan2")
                        Text("Al-Qatami").tag("athan3")
                        Text("Güneşdoğdu").tag("athan4")
                    }
                    Button(duhrPlayer.isPlaying ? "Stop" : "Play") {
                        playAthan(settings.duhr, with: duhrPlayer)
                    }
                }
                
                HStack {
                    Picker("Asr", selection: settings.$asr) {
                        Text("None").tag("none")
                        Divider()
                        Text("Alafasy").tag("athan1")
                        Text("Mullah").tag("athan2")
                        Text("Al-Qatami").tag("athan3")
                        Text("Güneşdoğdu").tag("athan4")
                    }
                    Button(asrPlayer.isPlaying ? "Stop" : "Play") {
                        playAthan(settings.asr, with: asrPlayer)
                    }
                }
                
                HStack {
                    Picker("Maghrib", selection: settings.$maghrib) {
                        Text("None").tag("none")
                        Divider()
                        Text("Alafasy").tag("athan1")
                        Text("Mullah").tag("athan2")
                        Text("Al-Qatami").tag("athan3")
                        Text("Güneşdoğdu").tag("athan4")
                    }
                    Button(maghribPlayer.isPlaying ? "Stop" : "Play") {
                        playAthan(settings.maghrib, with: maghribPlayer)
                    }
                }
                
                HStack {
                    Picker("Isha", selection: settings.$isha) {
                        Text("None").tag("none")
                        Divider()
                        Text("Alafasy").tag("athan1")
                        Text("Mullah").tag("athan2")
                        Text("Al-Qatami").tag("athan3")
                        Text("Güneşdoğdu").tag("athan4")
                    }
                    Button(ishaPlayer.isPlaying ? "Stop" : "Play") {
                        playAthan(settings.isha, with: ishaPlayer)
                    }
                }
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
    
    private func playAthan(_ athan: String, with player: AudioPlayer) {
        if player.isPlaying {
            player.stop()
        } else {
            stopAllPlayersExcept(player)
            player.audio = athan
            player.play()
        }
    }
    
    private func stopAllPlayersExcept(_ playerToExclude: AudioPlayer) {
        let allPlayers = [fajrPlayer, duhrPlayer, asrPlayer, maghribPlayer, ishaPlayer]
        for player in allPlayers {
            if player !== playerToExclude {
                player.stop()
            }
        }
    }
}

