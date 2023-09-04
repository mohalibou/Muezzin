//
//  MNotificationPicker.swift
//  Muezzin
//
//  Created by Mohamed Ali Boutaleb on 8/25/23.
//

import SwiftUI

struct MNotificationPicker: View {
    
    @EnvironmentObject private var vm: MuezzinViewModel
    
    var name: String
    @Binding var selection: Sound
    @ObservedObject var audioPlayer: AudioPlayer
    var allAudioPlayers: [AudioPlayer]
    
    var body: some View {
        HStack {
            Picker(name, selection: $selection) {
                Text("None").tag(Sound.none)
                Divider()
                if name == "Fajr" { Text("Alafasy (Fajr)").tag(Sound.athan1Fajr) }
                Text("Alafasy").tag(Sound.athan1)
                Text("Mullah").tag(Sound.athan2)
                Text("Al-Qatami").tag(Sound.athan3)
                Text("Güneşdoğdu").tag(Sound.athan4)
            }
            Button(audioPlayer.isPlaying ? "Stop" : "Play") {
                audioPlayer.isPlaying ? stopAthan() : playAthan()
            }
        }
    }
    
    private func playAthan() {
        allAudioPlayers.forEach { audioPlayer in
            audioPlayer.stop()
        }
        audioPlayer.audio = selection
        audioPlayer.play()
    }
    
    private func stopAthan() {
        allAudioPlayers.forEach { audioPlayer in
            audioPlayer.stop()
        }
    }
}
