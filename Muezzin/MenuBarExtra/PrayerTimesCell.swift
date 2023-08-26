//
//  PrayerTimesCell.swift
//  Muezzin
//
//  Created by Mohamed Ali Boutaleb on 8/25/23.
//

import SwiftUI

struct PrayerTimesCell: View {
    
    @State private var isHovering = false
    var prayer: String
    var time: String
    
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
    
    var body: some View {
        LabeledContent {
            Spacer()
            Text(time)
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
    }
    
    var notifButton: some View {
        Button {
            print("pressed")
        } label: {
            Image(systemName: "bell.fill")
                .scaledToFit()
                .frame(width: 20)
                .shadow(color: .accentColor.opacity(isHovering ? 1 : 0), radius: 6, x: 0, y: 0)
        }
        .buttonStyle(.plain)
        .onHover { hovering in
            withAnimation {
                isHovering = hovering
            }
        }
    }
}
