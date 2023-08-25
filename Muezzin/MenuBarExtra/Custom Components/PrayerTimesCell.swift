//
//  PrayerTimesCell.swift
//  Muezzin
//
//  Created by Mohamed Ali Boutaleb on 4/19/23.
//

import SwiftUI

struct PrayerTimesCell: View {
    
    @StateObject private var settings = AppSettings.shared
    
    @State private var isHovering = false
    
    var name: String
    var time: String
    @Binding var notification: String
    
    var image: String {
        switch name {
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
    
    var icon: String {
        if notification != "none" {
            return "bell.fill"
        } else {
            return "bell.slash"
        }
    }
    
    var color: Color {
        switch(icon) {
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
    
    
    
    var notificationIcons: [String] = ["bell.slash", "bell.fill", "pause.fill"]
    
    var body: some View {
        HStack {
            Label {
                Text(name)
            } icon: {
                Image(systemName: image)
                    .scaledToFit()
                    .frame(width: 20)
            }
            Spacer()
            Text(time)
            
            if !settings.silentMode {
                Button {
                    if notification != "none" {
                        notification = "none"
                    } else {
                        notification = (name == "Fajr" ? "athan1_fajr" : "athan1")
                    }
                } label: {
                    Image(systemName: icon)
                        .scaledToFit()
                        .frame(width: 20)
                        .symbolRenderingMode(.palette)
                        .foregroundStyle(color, .primary)
                        .shadow(color: .accentColor.opacity(isHovering ? 1 : 0), radius: 6, x: 0, y: 0)
                        .onHover { hovering in
                            withAnimation {
                                isHovering = hovering
                            }
                        }
                }
                .buttonStyle(.plain)
            }
        }
        .font(.title3)
        .padding(.vertical, 2)
        
    }
}
