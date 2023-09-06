//
//  PrayerTimesCell.swift
//  Muezzin
//
//  Created by Mohamed Ali Boutaleb on 8/25/23.
//

import SwiftUI

struct PrayerTimesCell: View {
    
    @StateObject private var settings = AppSettings.shared
    @EnvironmentObject var vm: MuezzinViewModel
    
    var prayer: String
    @Binding var time: Date
    
    var image: String {
        switch prayer {
        case "Fajr":
            return "light.max"
        case "Sunrise":
            return "sunrise.fill"
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
    
    var athanSound: Sound {
        switch prayer {
        case "Fajr":
            return settings.fajrAthan
        case "Sunrise":
            return settings.fajrAthan
        case "Duhr":
            return settings.duhrAthan
        case "Asr":
            return settings.asrAthan
        case "Maghrib":
            return settings.maghribAthan
        case "Isha":
            return settings.ishaAthan
        default:
            return Sound.none
        }
    }
    
    var notifIcon: (name: String, color: Color) {
        if prayer == "Sunrise" {
            return ("", .primary)
        } else if prayer == vm.whichPrayerIsItTimeFor && vm.audioPlayer.isPlaying {
            return ("pause.fill", .accentColor)
        } else {
            switch athanSound {
            case Sound.none:
                return ("bell.slash", .red)
            default:
                return ("bell.fill", .primary)
            }
        }
    }
    
    var body: some View {
        LabeledContent {
            Spacer()
            Text(vm.formatter.string(from: time))
            //Text(time.time.formatted(date: .omitted, time: .shortened))
            !settings.silentMode ? notifButton : nil
        } label: {
            HStack {
                Image(systemName: image)
                    .scaledToFit()
                    .frame(width: 20)
                Text(prayer)
            }
        }
        .font(.title3)
    }
    
    @State private var isHovering = false
    var notifButton: some View {
        Button {
            if vm.audioPlayer.isPlaying {
                vm.whichPrayerIsItTimeFor = ""
                vm.audioPlayer.stop()
            } else {
                toggle()
            }
        } label: {
            Image(systemName: notifIcon.name)
                .scaledToFit()
                .frame(width: 20)
                .symbolRenderingMode(.palette)
                .foregroundStyle(notifIcon.color, .primary)
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
            settings.fajrAthan = (settings.fajrAthan == Sound.none ? Sound.athan1Fajr : Sound.none)
        case "Duhr":
            settings.duhrAthan = (settings.duhrAthan == Sound.none ? Sound.athan1 : Sound.none)
        case "Asr":
            settings.asrAthan = (settings.asrAthan == Sound.none ? Sound.athan1 : Sound.none)
        case "Maghrib":
            settings.maghribAthan = (settings.maghribAthan == Sound.none ? Sound.athan1 : Sound.none)
        case "Isha":
            settings.ishaAthan = (settings.ishaAthan == Sound.none ? Sound.athan1 : Sound.none)
        default:
            break
        }
    }
}
