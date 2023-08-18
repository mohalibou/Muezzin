//
//  ContentView.swift
//  Muezzin
//
//  Created by Mohamed Ali Boutaleb on 4/17/23.
//

import SwiftUI
import Adhan

struct SettingsView: View {
    var body: some View {
        TabView {
            SettingsGeneralView()
                .tabItem { Label("General", systemImage: "gearshape.fill") }
            
            SettingsLocationView()
                .tabItem { Label("Location", systemImage: "location.fill") }
            
            SettingsPrayerTimesView()
                .tabItem { Label("Prayer Times", systemImage: "clock.fill") }
            
            SettingsNotificationsView()
                .tabItem { Label("Notifications", systemImage: "speaker.wave.2.fill") }
            
            SettingsAdvancedView()
                .tabItem { Label("Advanced", systemImage: "wrench.and.screwdriver.fill") }
        }
        .frame(width: 400, height: 400)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        SettingsView()
    }
}
