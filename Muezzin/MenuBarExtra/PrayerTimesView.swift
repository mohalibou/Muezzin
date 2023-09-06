//
//  PrayerTimesView.swift
//  Muezzin
//
//  Created by Mohamed Ali Boutaleb on 8/24/23.
//

import SwiftUI

struct PrayerTimesView: View {
    
    @EnvironmentObject var vm: MuezzinViewModel
    
    var body: some View {
        VStack {
            PrayerTimesCell(prayer: "Fajr", time: $vm.fajrTime)
            Divider()
            PrayerTimesCell(prayer: "Sunrise", time: $vm.sunriseTime)
            Divider()
            PrayerTimesCell(prayer: "Duhr", time: $vm.duhrTime)
            Divider()
            PrayerTimesCell(prayer: "Asr", time: $vm.asrTime)
            Divider()
            PrayerTimesCell(prayer: "Maghrib", time: $vm.maghribTime)
            Divider()
            PrayerTimesCell(prayer: "Isha", time: $vm.ishaTime)
        }
        .padding(.vertical, 3)
        .padding(.horizontal, 6)
        .frame(maxWidth: .infinity)
    }
}

#Preview {
    PrayerTimesView()
}
