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
    var image: String
    var notification: String
    
    var color: Color {
        switch(notification) {
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
                    if name == "Fajr" {
                        if settings.fajr != "none" {
                            settings.fajr = "none"
                        } else {
                            settings.fajr = "athan1_fajr"
                        }
                    } else if name == "Duhr" {
                        if settings.duhr != "none" {
                            settings.duhr = "none"
                        } else {
                            settings.duhr = "athan1"
                        }
                    } else if name == "Asr" {
                        if settings.asr != "none" {
                            settings.asr = "none"
                        } else {
                            settings.asr = "athan1"
                        }
                    } else if name == "Maghrib" {
                        if settings.maghrib != "none" {
                            settings.maghrib = "none"
                        } else {
                            settings.maghrib = "athan1"
                        }
                    } else if name == "Isha" {
                        if settings.isha != "none" {
                            settings.isha = "none"
                        } else {
                            settings.isha = "athan1"
                        }
                    }
                } label: {
                    Image(systemName: notification)
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
        .padding(.horizontal, 6)
        .padding(.vertical, 2)
        
    }
}
