//
//  PrayerTimesView.swift
//  Muezzin
//
//  Created by Mohamed Ali Boutaleb on 4/19/23.
//

import Adhan
import SwiftUI

struct PrayerTimesView: View {
    
    @EnvironmentObject private var locationManager: LocationManager
    @StateObject private var settings = AppSettings.shared
    @ObservedObject var vm: MuezzinViewModel
    
    var fajrTime: String {
        let timeZone: String = reverseGeocode(for: .timezone, location: locationManager.coordinates) { _ in }
        
        
        
        vm.getTodayPrayerTimes(coords: locationManager.coordinates, calcMethod: settings.calculationMethod, madhab: settings.asrCalculation, timeZone: reverseGeocode()[0]
    }
    var duhrTime: String {
        vm.getTodayPrayerTimes(coords: locationManager.coordinates, calcMethod: settings.calculationMethod, madhab: settings.asrCalculation, timeZone: "America/Los_Angeles")[1]
    }
    var asrTime: String {
        vm.getTodayPrayerTimes(coords: locationManager.coordinates, calcMethod: settings.calculationMethod, madhab: settings.asrCalculation, timeZone: "America/Los_Angeles")[2]
    }
    var maghribTime: String {
        vm.getTodayPrayerTimes(coords: locationManager.coordinates, calcMethod: settings.calculationMethod, madhab: settings.asrCalculation, timeZone: "America/Los_Angeles")[3]
    }
    var ishaTime: String {
        vm.getTodayPrayerTimes(coords: locationManager.coordinates, calcMethod: settings.calculationMethod, madhab: settings.asrCalculation, timeZone: "America/Los_Angeles")[4]
    }
    
    var body: some View {
        VStack {
            PrayerTimesCell(name: "Fajr", time: fajrTime, notification: settings.$fajr)
                .padding(.top, 3)
            Divider()
            PrayerTimesCell(name: "Duhr", time: duhrTime, notification: settings.$duhr)
            Divider()
            PrayerTimesCell(name: "Asr", time: asrTime, notification: settings.$asr)
            Divider()
            PrayerTimesCell(name: "Maghrib", time: maghribTime, notification: settings.$maghrib)
            Divider()
            PrayerTimesCell(name: "Isha", time: ishaTime, notification: settings.$isha)
                .padding(.bottom, 3)
        }
        .padding(.horizontal, 6)
    }
}
