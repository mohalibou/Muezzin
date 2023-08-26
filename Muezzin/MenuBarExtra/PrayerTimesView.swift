//
//  PrayerTimesView.swift
//  Muezzin
//
//  Created by Mohamed Ali Boutaleb on 8/24/23.
//

import SwiftUI

struct PrayerTimesView: View {
    var body: some View {
        VStack {
            PrayerTimesCell(prayer: "Fajr", time: "6:00 AM")
            Divider()
            PrayerTimesCell(prayer: "Duhr", time: "12:00 PM")
            Divider()
            PrayerTimesCell(prayer: "Asr", time: "3:00 PM")
            Divider()
            PrayerTimesCell(prayer: "Maghrib", time: "6:00 PM")
            Divider()
            PrayerTimesCell(prayer: "Isha", time: "9:00 PM")
        }
        .padding(.vertical, 3)
        .padding(.horizontal, 6)
        .frame(maxWidth: .infinity)
        
    }
}

#Preview {
    PrayerTimesView()
}
