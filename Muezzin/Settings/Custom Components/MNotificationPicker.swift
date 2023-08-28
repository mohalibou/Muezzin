//
//  MNotificationPicker.swift
//  Muezzin
//
//  Created by Mohamed Ali Boutaleb on 8/25/23.
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
                selection
            }
            Button(audioPlayer.isPlaying ? "Stop" : "Play") {
                playAthan(setting, with: audioPlayer)
            }
            .disabled(setting == Sound.none ? true : false)
        }
    }
    
    var selection: some View {
        Group {
            Text("None").tag(Sound.none)
            Divider()
            if name == "Fajr" { Text("Alafasy (Fajr)").tag(Sound.athan1Fajr) }
            Text("Alafasy").tag(Sound.athan1)
            Text("Mullah").tag(Sound.athan2)
            Text("Al-Qatami").tag(Sound.athan3)
            Text("Güneşdoğdu").tag(Sound.athan4)
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
