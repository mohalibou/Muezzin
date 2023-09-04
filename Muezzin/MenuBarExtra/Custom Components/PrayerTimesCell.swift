//
//  PrayerTimesCell.swift
//  Muezzin
//
//  Created by Mohamed Ali Boutaleb on 8/25/23.
//

import SwiftUI

struct PrayerTimesCell: View {
    
    var prayer: String
    var time: Date
    
    @EnvironmentObject var vm: MuezzinViewModel
    
    @StateObject private var settings = AppSettings.shared
    @StateObject private var audioPlayer = AudioPlayer()
    @State private var isHovering = false
    
    var image: String {
        switch prayer {
        case "Fajr":
            return "light.max"
        case "Duhr":
            return "sun.max.fill"
        case "Asr":
            return "sun.min.fill"
        case "Maghrib":
            return "sunset.fill"
        case "Isha":
            return "moon.stars.fill"
        default:
            return ""
        }
    }
    
    var athanSound: String {
        switch prayer {
        case "Fajr":
            return settings.fajr
        case "Duhr":
            return settings.duhr
        case "Asr":
            return settings.asr
        case "Maghrib":
            return settings.maghrib
        case "Isha":
            return settings.isha
        default:
            return ""
        }
    }
    
    var notifIcon: String {
        if vm.audioPlayer.isPlaying && vm.audioPlayer.audio == athanSound {
            return "pause.fill"
        } else {
            switch athanSound {
            case "none":
                return "bell.slash"
            default:
                return "bell.fill"
            }
        }
        
    }
    
    var color: Color {
        switch notifIcon {
        case "bell.slash":
            return .red
        case "bell.fill":
            return .primary
        case "pause.fill":
            return .accentColor
        default:
            return .primary
        }
    }
    
    var formatter1: DateFormatter {
        let formatter = DateFormatter()
        formatter.timeStyle = .short
        formatter.timeZone = TimeZone(identifier: settings.customTimeZone)!
        return formatter
    }
    
    var formatter2: DateFormatter {
        let formatter = DateFormatter()
        formatter.timeStyle = .medium
        formatter.timeZone = TimeZone(identifier: settings.customTimeZone)!
        return formatter
    }
    
    
    var body: some View {
        LabeledContent {
            Spacer()
            Text(formatter1.string(from: time))
            notifButton
        } label: {
            HStack {
                Image(systemName: image)
                    .scaledToFit()
                    .frame(width: 20)
                Text(prayer)
            }
        }
        .font(.title3)
        .onReceive(Timer.publish(every: 1, on: .main, in: .common).autoconnect()) { _ in
            print("Current time: \(Date().formatted(date: .omitted, time: .standard))")
            print("Prayer time:  \(formatter2.string(from: time)) - \(prayer) - \(settings.customTimeZone)")
            if Date().formatted(date: .omitted, time: .standard) == formatter2.string(from: time) {
                print("It's time!")
                if athanSound != Sound.none {
                    playAthan(athanSound, with: audioPlayer)
                }
            }
        }
    }
    
    var notifButton: some View {
        Button {
            if audioPlayer.isPlaying {
                audioPlayer.stop()
            } else {
                toggle()
            }
        } label: {
            Image(systemName: notifIcon)
                .scaledToFit()
                .frame(width: 20)
                .symbolRenderingMode(.palette)
                .foregroundStyle(color, .primary)
                .shadow(color: .accentColor.opacity(isHovering ? 1 : 0), radius: 6, x: 0, y: 0)
        }
        .buttonStyle(.plain)
        .onHover { hovering in
            withAnimation {
                isHovering = hovering
            }
        }
    }
    
    func toggle() {
        switch prayer {
        case "Fajr":
            settings.fajr = (settings.fajr == "none" ? "athan1_fajr" : "none")
        case "Duhr":
            settings.duhr = (settings.duhr == "none" ? "athan1" : "none")
        case "Asr":
            settings.asr = (settings.asr == "none" ? "athan1" : "none")
        case "Maghrib":
            settings.maghrib = (settings.maghrib == "none" ? "athan1" : "none")
        case "Isha":
            settings.isha = (settings.isha == "none" ? "athan1" : "none")
        default:
            break
        }
    }
    
    private func playAthan(_ athan: String, with player: AudioPlayer) {
        player.audio = athan
        if settings.playDuaAfterAthan {
            player.nextAudio = Sound.dua // Set the name of the next audio file here
        }
        player.play()
    }
}
