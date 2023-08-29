//
//  MuezzinApp.swift
//  Muezzin
//
//  Created by Mohamed Ali Boutaleb on 4/17/23.
//

import SwiftUI

@main
struct MuezzinApp: App {
    
    @StateObject private var settings = AppSettings.shared
    var vm = MuezzinViewModel()
    
    var body: some Scene {
        MenuBarExtra {
            MuezzinView()
                .environmentObject(vm)
                
        } label: {
            menuBarLabel
                .onReceive(Timer.publish(every: 1, on: .main, in: .common).autoconnect()) { _ in
                    vm.getPrayerTimes()
                    
                    let cal = Calendar(identifier: Calendar.Identifier.gregorian)
                    let date = cal.dateComponents([.year, .month, .day], from: Date())
                    
                    let times = [vm.fajrTime, vm.duhrTime, vm.asrTime, vm.maghribTime, vm.ishaTime]
                    let sounds = [settings.fajr, settings.duhr, settings.asr, settings.maghrib, settings.isha]
                    let prayers = ["Fajr", "Duhr", "Asr", "Maghrib", "Isha"]
                    
                    print(date)
                    print("Current time: \(Date().formatted(date: .omitted, time: .standard))")
                    for i in times.indices {
                        print("Prayer time:  \(vm.formatter.string(from: times[i])) - \(prayers[i]) - \(settings.customTimeZone)")
                    }
                    
                    for i in times.indices {
                        if times[i] == Date() && sounds[i] != Sound.none {
                            print("It's time!")
                            vm.playAthan(sound: sounds[i])
                            break
                        }
                    }
                }
        }
        .menuBarExtraStyle(.window)
        
        Settings {
            SettingsView()
        }
        
        Window("", id: "about") {
            AboutView()
        }
        .windowResizability(.contentSize)
    }
    
    var menuBarLabel: some View {
        HStack {
            if settings.displayIcon {
                Image(systemName: "person")
            }
            if settings.displayNextPrayer {
                Text("Hello")
            }
        }
    }
}
