//
//  SettingsPrayerTimesView.swift
//  Muezzin
//
//  Created by Mohamed Ali Boutaleb on 8/25/23.
//

import Adhan
import SwiftUI

struct SettingsPrayerTimesView: View {
    
    @StateObject private var settings = AppSettings.shared
    
    @State private var showSunriseTime = false
    @State private var showMidnightTime = false
    @State private var showTahajjudTime = false
    
    var body: some View {
        Form {
            Section {
                Picker("Calculation Method", selection: settings.$calculationMethod) {
                    ForEach(CalculationMethod.usefulCases(), id: \.self) { calcMethod in
                        Text(calcMethod.localizedString())
                    }
                }
                
                Picker("Asr Calculation", selection: settings.$asrCalculation) {
                    Text("Standard").tag(Madhab.shafi)
                    Text("Hanafi").tag(Madhab.hanafi)
                }
            }
            /*
            Section {
                Toggle("Show sunrise time", isOn: $showSunriseTime)
                Toggle("Show midnight time", isOn: $showMidnightTime)
                Toggle("Show tahajjud time", isOn: $showTahajjudTime)
            }*/
        }
        .formStyle(.grouped)
    }
}
