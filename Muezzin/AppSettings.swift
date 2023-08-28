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
    
    // Location Settings
    //@AppStorage("useCurrentLocation") var useCurrentLocation: Bool = false
    @AppStorage("customLocationLatitude") var customLocationLatitude: Double?
    @AppStorage("customLocationLongitude") var customLocationLongitude: Double?
    @AppStorage("customTimeZone") var customTimeZone: String = TimeZone.current.identifier
    
    // Prayer Times Settings
    @AppStorage("calculationMethod") var calculationMethod: CalculationMethod = .moonsightingCommittee
    @AppStorage("asrCalculation") var asrCalculation: Madhab = .shafi
    
    // Notifications Settings
    @AppStorage("silentMode") var silentMode: Bool = false
    @AppStorage("fajr") var fajr: String = Sound.athan1Fajr
    @AppStorage("duhr") var duhr: String = Sound.athan1
    @AppStorage("asr") var asr: String = Sound.athan1
    @AppStorage("maghrib") var maghrib: String = Sound.athan1
    @AppStorage("isha") var isha: String = Sound.athan1
    @AppStorage("playDuaAfterAthan") var playDuaAfterAthan: Bool = false
}
