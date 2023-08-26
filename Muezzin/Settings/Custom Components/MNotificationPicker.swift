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
    @StateObject private var audioPlayer = AudioPlayer()
    
    var body: some View {
        HStack {
            Picker(name, selection: $setting) {
                selection
            }
            Button(audioPlayer.isPlaying ? "Stop" : "Play") {
                playAthan(setting, with: audioPlayer)
            }
            .disabled(setting == "none" ? true : false)
        }
    }
    
    var selection: some View {
        Group {
            Text("None").tag("none")
            Divider()
            if name == "Fajr" { Text("Alafasy (Fajr)").tag("athan1_fajr") }
            Text("Alafasy").tag("athan1")
            Text("Mullah").tag("athan2")
            Text("Al-Qatami").tag("athan3")
            Text("Güneşdoğdu").tag("athan4")
        }
    }
    
    private func playAthan(_ athan: String, with player: AudioPlayer) {
        if player.isPlaying {
            player.stop()
        } else {
            player.audio = athan
            player.play()
        }
    }
}
