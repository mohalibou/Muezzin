//
//  ContentView.swift
//  Muezzin
//
//  Created by Mohamed Ali Boutaleb on 4/17/23.
//

import SwiftUI
import Adhan

struct SettingsView: View {
    
    @State private var selectedMadhab: Madhab = .shafi
    @State private var selectedCalculation: CalculationMethod = .moonsightingCommittee
    
    private let athans = ["Athan1", "Athan2", "Athan3", "Athan4", "Athan5"]
    @State private var fajr = "Athan1"
    @State private var duhr = "Athan1"
    @State private var asr = "Athan1"
    @State private var maghrib = "Athan1"
    @State private var isha = "Athan1"
    
    @State private var flag: Bool = false
    
    var body: some View {
        TabView {
            general
                .tabItem { Label("General", systemImage: "gearshape.fill") }
            
            location
                .tabItem { Label("Location", systemImage: "location.fill") }
            
            prayerTimes
                .tabItem { Label("Prayer Times", systemImage: "clock.fill") }
            
            notifications
                .tabItem { Label("Notifications", systemImage: "speaker.wave.2.fill") }
            
            advanced
                .tabItem { Label("Advanced", systemImage: "wrench.and.screwdriver.fill") }
        }
        .frame(width: 400, height: 400)
    }
    
    var general: some View {
        Form {
            Text("Hello")
        }
        .formStyle(.grouped)
    }
    
    var location: some View {
        Form {
            Text("Hello")
        }
        .formStyle(.grouped)
    }
    
    var prayerTimes: some View {
        Form {
            Picker("Calculation Method", selection: $selectedCalculation) {
                ForEach(CalculationMethod.usefulCases(), id: \.self) { calcMethod in
                    Text(calcMethod.localizedString())
                }
            }
            
            Picker("Asr Calculation", selection: $selectedMadhab) {
                ForEach(Madhab.allCases, id: \.self) { madhab in
                    Text(madhab == .shafi ? "Standard" : "Hanafi")
                }
            }
        }
        .formStyle(.grouped)
    }
    
    var notifications: some View {
        Form {
            Section {
                Toggle("Silent Mode", isOn: $flag)
            }
            
            Section {
                HStack {
                    Picker("Fajr", selection: $fajr) {
                        ForEach(athans, id: \.self) { athan in
                            Text(athan)
                        }
                    }
                    Button("Play") { print("pressed") }
                }
                HStack {
                    Picker("Duhr", selection: $duhr) {
                        ForEach(athans, id: \.self) { athan in
                            Text(athan)
                        }
                    }
                    Button("Play") { print("pressed") }
                }
                
                HStack {
                    Picker("Asr", selection: $asr) {
                        ForEach(athans, id: \.self) { athan in
                            Text(athan)
                        }
                    }
                    Button("Play") { print("pressed") }
                }
                
                HStack {
                    Picker("Maghrib", selection: $maghrib) {
                        ForEach(athans, id: \.self) { athan in
                            Text(athan)
                        }
                    }
                    Button("Play") { print("pressed") }
                }
                
                HStack {
                    Picker("Isha", selection: $isha) {
                        ForEach(athans, id: \.self) { athan in
                            Text(athan)
                        }
                    }
                    Button("Play") { print("pressed") }
                }
            }
            .disabled(flag)
        }
        .formStyle(.grouped)
        
    }
    
    var advanced: some View {
        Form {
            Text("Hello")
        }
        .formStyle(.grouped)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        SettingsView()
    }
}
