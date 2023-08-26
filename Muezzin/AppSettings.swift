//
//  AppSettings.swift
//  Muezzin
//
//  Created by Mohamed Ali Boutaleb on 8/25/23.
//

import Adhan
import CoreLocation
import SwiftUI

final class AppSettings: ObservableObject {
    
    static let shared = AppSettings()
    private init() { }
    
    // General Settings
    @AppStorage("startAtLogin") var startAtLogin: Bool = false
    @AppStorage("displayIcon") var displayIcon: Bool = true
    @AppStorage("displayNextPrayer") var displayNextPrayer: Bool = true
    
    //@AppStorage("useCurrentLocation") var useCurrentLocation: Bool = false
    @AppStorage("customLocationLatitude") var customLocationLatitude: Double?
    @AppStorage("customLocationLongitude") var customLocationLongitude: Double?
    @AppStorage("customTimeZone") var customTimeZone: String = TimeZone.current.identifier
    
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
