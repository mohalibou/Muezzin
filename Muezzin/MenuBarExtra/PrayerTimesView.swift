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
            PrayerTimesCell(prayer: "Fajr", time: $vm.fajr)
            Divider()
            PrayerTimesCell(prayer: "Sunrise", time: $vm.sunrise)
            Divider()
            PrayerTimesCell(prayer: "Duhr", time: $vm.duhr)
            Divider()
            PrayerTimesCell(prayer: "Asr", time: $vm.asr)
            Divider()
            PrayerTimesCell(prayer: "Maghrib", time: $vm.maghrib)
            Divider()
            PrayerTimesCell(prayer: "Isha", time: $vm.isha)
        }
        .padding(.vertical, 3)
        .padding(.horizontal, 6)
        .frame(maxWidth: .infinity)
    }
}

#Preview {
    PrayerTimesView()
}
