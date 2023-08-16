//
//  PrayerTimesView.swift
//  Muezzin
//
//  Created by Mohamed Ali Boutaleb on 4/19/23.
//

import SwiftUI

struct PrayerTimesView: View {
    var body: some View {
        PrayerTimesCell(name: "Fajr", time: "6:00 AM",  image: "light.max", notification: "megaphone.fill")
            .padding(.top, 3)
        Divider().padding(.horizontal, 6)
        PrayerTimesCell(name: "Duhr", time: "12:00 PM", image: "sun.max.fill", notification: "bell.fill")
        Divider().padding(.horizontal, 6)
        PrayerTimesCell(name: "Asr", time: "3:00 PM",  image: "sun.min.fill", notification: "bell.slash")
        Divider().padding(.horizontal, 6)
        PrayerTimesCell(name: "Maghrib", time: "6:00 PM",  image: "sunset.fill", notification: "bell.fill")
        Divider().padding(.horizontal, 6)
        PrayerTimesCell(name: "Isha", time: "9:00 PM",  image: "moon.stars.fill", notification: "megaphone.fill")
            .padding(.bottom, 3)
    }
}

struct PrayerTimesView_Previews: PreviewProvider {
    static var previews: some View {
        PrayerTimesView()
    }
}
