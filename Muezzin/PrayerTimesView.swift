//
//  PrayerTimesView.swift
//  Muezzin
//
//  Created by Mohamed Ali Boutaleb on 4/19/23.
//

import SwiftUI

struct PrayerTimesView: View {
    
    @StateObject private var settings = AppSettings.shared
    
    var body: some View {
        PrayerTimesCell(name: "Fajr", time: "6:00 AM",  image: "light.max", notification: icon(for: settings.fajr))
            .padding(.top, 3)
        Divider().padding(.horizontal, 6)
        PrayerTimesCell(name: "Duhr", time: "12:00 PM", image: "sun.max.fill", notification: icon(for: settings.duhr))
        Divider().padding(.horizontal, 6)
        PrayerTimesCell(name: "Asr", time: "3:00 PM",  image: "sun.min.fill", notification: icon(for: settings.asr))
        Divider().padding(.horizontal, 6)
        PrayerTimesCell(name: "Maghrib", time: "6:00 PM",  image: "sunset.fill", notification: icon(for: settings.maghrib))
        Divider().padding(.horizontal, 6)
        PrayerTimesCell(name: "Isha", time: "9:00 PM",  image: "moon.stars.fill", notification: "pause.fill")
            .padding(.bottom, 3)
    }
    
    private func icon(for prayerSetting: String) -> String {
        return prayerSetting == "none" ? "bell.slash" : "bell.fill"
    }
}

struct PrayerTimesView_Previews: PreviewProvider {
    static var previews: some View {
        PrayerTimesView()
    }
}
