//
//  SettingsPrayerTimesView.swift
//  Muezzin
//
//  Created by Mohamed Ali Boutaleb on 8/17/23.
//

import Adhan
import SwiftUI

struct SettingsPrayerTimesView: View {
    
    @State private var selectedMadhab: Madhab = .shafi
    @State private var selectedCalculation: CalculationMethod = .moonsightingCommittee
    
    var body: some View {
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
}
