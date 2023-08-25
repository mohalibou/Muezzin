//
//  MNotificationPicker.swift
//  Muezzin
//
//  Created by Mohamed Ali Boutaleb on 8/24/23.
//

import SwiftUI

struct MNotificationPicker: View {
    
    var name: String
    @Binding var setting: String
    @ObservedObject var audioPlayer: AudioPlayer
    var allPlayers: [AudioPlayer]
    
    var body: some View {
        HStack {
            Picker(name, selection: $setting) {
                Text("None").tag("none")
                Divider()
                if name == "Fajr" { Text("Alafasy (Fajr)").tag("athan1_fajr") }
                Text("Alafasy").tag("athan1")
                Text("Mullah").tag("athan2")
                Text("Al-Qatami").tag("athan3")
                Text("Güneşdoğdu").tag("athan4")
            }
            Button(audioPlayer.isPlaying ? "Stop" : "Play") {
                playAthan(setting, with: audioPlayer)
            }
            .disabled(setting == "none" ? true : false)
        }
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
        for player in allPlayers {
            if player !== playerToExclude {
                player.stop()
            }
        }
    }
}
