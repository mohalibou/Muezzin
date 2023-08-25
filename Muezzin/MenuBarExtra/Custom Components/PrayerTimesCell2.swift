//
//  PrayerTimesCell2.swift
//  Muezzin
//
//  Created by Mohamed Ali Boutaleb on 8/24/23.
//

import Adhan
import SwiftUI

struct PrayerTimesCell2: View {
    
    var name: String
    var time: String
    var setting: String
    
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
            
        }
        .font(.title3)
        .padding(.horizontal, 6)
        .padding(.vertical, 2)
    }
}
