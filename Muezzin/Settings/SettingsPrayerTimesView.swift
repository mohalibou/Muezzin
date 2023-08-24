//
//  SettingsPrayerTimesView.swift
//  Muezzin
//
//  Created by Mohamed Ali Boutaleb on 8/17/23.
//

import Adhan
import SwiftUI

struct SettingsPrayerTimesView: View {
    
    @StateObject private var settings = AppSettings.shared
    
    @State private var flag1 = false
    @State private var flag2 = false
    @State private var flag3 = false
    
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
            
            Section {
                Toggle("Show sunrise time", isOn: $flag1)
                Toggle("Show midnight time", isOn: $flag2)
                Toggle("Show tahajjud time", isOn: $flag3)
            }
        }
        .formStyle(.grouped)
    }
}
