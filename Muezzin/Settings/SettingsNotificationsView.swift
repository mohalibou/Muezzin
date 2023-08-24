//
//  SettingsNotificationsView.swift
//  Muezzin
//
//  Created by Mohamed Ali Boutaleb on 8/17/23.
//

import SwiftUI

struct SettingsNotificationsView: View {
    
    @StateObject private var fajrPlayer = AudioPlayer()
    @StateObject private var duhrPlayer = AudioPlayer()
    @StateObject private var asrPlayer = AudioPlayer()
    @StateObject private var maghribPlayer = AudioPlayer()
    @StateObject private var ishaPlayer = AudioPlayer()
    
    @State private var fajr = "athan1_fajr"
    @State private var duhr = "athan1"
    @State private var asr = "athan2"
    @State private var maghrib = "athan3"
    @State private var isha = "athan4"
    
    @State private var flag: Bool = false
    @State private var flag2: Bool = false
    
    var body: some View {
        Form {
            Section {
                Toggle("Silent Mode", isOn: $flag)
            }
            
            Section {
                HStack {
                    Picker("Fajr", selection: $fajr) {
                        Text("Alafasy (Fajr)").tag("athan1_fajr")
                        Divider()
                        Text("Alafasy").tag("athan1")
                        Text("Mullah").tag("athan2")
                        Text("Al-Qatami").tag("athan3")
                        Text("Güneşdoğdu").tag("athan4")
                    }
                    Button(fajrPlayer.isPlaying ? "Stop" : "Play") {
                        playAthan(fajr, with: fajrPlayer)
                    }
                }
                HStack {
                    Picker("Duhr", selection: $duhr) {
                        Text("Alafasy").tag("athan1")
                        Text("Mullah").tag("athan2")
                        Text("Al-Qatami").tag("athan3")
                        Text("Güneşdoğdu").tag("athan4")
                    }
                    Button(duhrPlayer.isPlaying ? "Stop" : "Play") {
                        playAthan(duhr, with: duhrPlayer)
                    }
                }
                
                HStack {
                    Picker("Asr", selection: $asr) {
                        Text("Alafasy").tag("athan1")
                        Text("Mullah").tag("athan2")
                        Text("Al-Qatami").tag("athan3")
                        Text("Güneşdoğdu").tag("athan4")
                    }
                    Button(asrPlayer.isPlaying ? "Stop" : "Play") {
                        playAthan(asr, with: asrPlayer)
                    }
                }
                
                HStack {
                    Picker("Maghrib", selection: $maghrib) {
                        Text("Alafasy").tag("athan1")
                        Text("Mullah").tag("athan2")
                        Text("Al-Qatami").tag("athan3")
                        Text("Güneşdoğdu").tag("athan4")
                    }
                    Button(maghribPlayer.isPlaying ? "Stop" : "Play") {
                        playAthan(maghrib, with: maghribPlayer)
                    }
                }
                
                HStack {
                    Picker("Isha", selection: $isha) {
                        Text("Alafasy").tag("athan1")
                        Text("Mullah").tag("athan2")
                        Text("Al-Qatami").tag("athan3")
                        Text("Güneşdoğdu").tag("athan4")
                    }
                    Button(ishaPlayer.isPlaying ? "Stop" : "Play") {
                        playAthan(isha, with: ishaPlayer)
                    }
                }
            }
            .disabled(flag)
            
            Section {
                Toggle("Play Dua After Athan", isOn: $flag2)
            }
            .disabled(flag)
            
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

