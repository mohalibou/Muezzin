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
    @AppStorage("prayerName") var prayerName: Name = .full
    @AppStorage("prayerTime") var prayerTime: Time = .time
    
    // Location Settings
    //@AppStorage("useCurrentLocation") var useCurrentLocation: Bool = false
    @AppStorage("customLocationLatitude") var customLocationLatitude: Double = 0
    @AppStorage("customLocationLongitude") var customLocationLongitude: Double = 0
    @AppStorage("customTimeZone") var customTimeZone: String = TimeZone.current.identifier
    
    // Prayer Times Settings
    @AppStorage("calculationMethod") var calculationMethod: CalculationMethod = .moonsightingCommittee
    @AppStorage("asrCalculation") var asrCalculation: Madhab = .shafi
    
    // Notifications Settings
    @AppStorage("silentMode") var silentMode: Bool = false
    @AppStorage("fajrAthan") var fajrAthan: Sound = .athan1Fajr
    @AppStorage("duhrAthan") var duhrAthan: Sound = .athan1
    @AppStorage("asrAthan") var asrAthan: Sound = .athan1
    @AppStorage("maghribAthan") var maghribAthan: Sound = .athan1
    @AppStorage("ishaAthan") var ishaAthan: Sound = .athan1
    @AppStorage("playDuaAfterAthan") var playDuaAfterAthan: Bool = false
}
