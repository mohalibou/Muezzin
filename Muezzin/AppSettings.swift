//
//  AppSettings.swift
//  Muezzin
//
//  Created by Mohamed Ali Boutaleb on 4/26/23.
//

import Adhan
import SwiftUI

final class AppSettings: ObservableObject {
    
    static let shared = AppSettings()
    private init() { }
    
    // General Settings
    @AppStorage("startAtLogin") var startAtLogin: Bool = false
    @AppStorage("displayIcon") var displayIcon: Bool = true
    @AppStorage("displayNextPrayer") var displayNextPrayer: Bool = true
    
    
    // Prayer Times Settings
    @AppStorage("calculationMethod") var calculationMethod: CalculationMethod = .moonsightingCommittee
    @AppStorage("asrCalculation") var asrCalculation: Madhab = .shafi
    
    // Notifications Settings
    @AppStorage("silentMode") var silentMode: Bool = false
    @AppStorage("fajr") var fajr: String = "athan1_fajr"
    @AppStorage("duhr") var duhr: String = "athan1"
    @AppStorage("asr") var asr: String = "athan2"
    @AppStorage("maghrib") var maghrib: String = "athan3"
    @AppStorage("isha") var isha: String = "athan4"
    @AppStorage("playDuaAfterAthan") var playDuaAfterAthan: Bool = false
}

