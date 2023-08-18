//
//  SettingsNotificationsView.swift
//  Muezzin
//
//  Created by Mohamed Ali Boutaleb on 8/17/23.
//

import SwiftUI

struct SettingsNotificationsView: View {
    
    @StateObject private var audioPlayer = AudioPlayer()
    
    private let athans = ["Athan1", "Athan2", "Athan3", "Athan4", "Athan5"]
    
    @State private var fajr = "athan1_fajr"
    @State private var duhr = "Athan1"
    @State private var asr = "Athan1"
    @State private var maghrib = "Athan1"
    @State private var isha = "Athan1"
    @State private var flag: Bool = false
    
    var body: some View {
        Form {
            Section {
                Toggle("Silent Mode", isOn: $flag)
            }
            
            Section {
                HStack {
                    Picker("Fajr", selection: $fajr) {
                        Text("Alafasy").tag("athan1_fajr")
                    }
                    Button(audioPlayer.isPlaying ? "Stop" : "Play") {
                        if audioPlayer.isPlaying {
                            audioPlayer.stop()
                        } else {
                            audioPlayer.audio = fajr
                            audioPlayer.play()
                        }
                        
                    }
                }
                HStack {
                    Picker("Duhr", selection: $duhr) {
                        ForEach(athans, id: \.self) { athan in
                            Text(athan)
                        }
                    }
                    Button("Play") { print("pressed") }
                }
                
                HStack {
                    Picker("Asr", selection: $asr) {
                        ForEach(athans, id: \.self) { athan in
                            Text(athan)
                        }
                    }
                    Button("Play") { print("pressed") }
                }
                
                HStack {
                    Picker("Maghrib", selection: $maghrib) {
                        ForEach(athans, id: \.self) { athan in
                            Text(athan)
                        }
                    }
                    Button("Play") { print("pressed") }
                }
                
                HStack {
                    Picker("Isha", selection: $isha) {
                        ForEach(athans, id: \.self) { athan in
                            Text(athan)
                        }
                    }
                    Button("Play") { print("pressed") }
                }
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
}

