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
        VStack {
            PrayerTimesCell(name: "Fajr", time: "6:00 AM", notification: settings.$fajr)
                .padding(.top, 3)
            Divider()
            PrayerTimesCell(name: "Duhr", time: "12:00 PM", notification: settings.$duhr)
            Divider()
            PrayerTimesCell(name: "Asr", time: "3:00 PM", notification: settings.$asr)
            Divider()
            PrayerTimesCell(name: "Maghrib", time: "6:00 PM", notification: settings.$maghrib)
            Divider()
            PrayerTimesCell(name: "Isha", time: "9:00 PM", notification: settings.$isha)
                .padding(.bottom, 3)
        }
        .padding(.horizontal, 6)
    }
}

struct PrayerTimesView_Previews: PreviewProvider {
    static var previews: some View {
        PrayerTimesView()
    }
}
