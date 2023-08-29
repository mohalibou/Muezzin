//
//  MuezzinViewModel.swift
//  Muezzin
//
//  Created by Mohamed Ali Boutaleb on 8/25/23.
//

import Adhan
import SwiftUI

class MuezzinViewModel: ObservableObject {
    
    var settings = AppSettings.shared
    
    var audioPlayer = AudioPlayer()
    
    var formatter: DateFormatter {
        let formatter = DateFormatter()
        formatter.timeStyle = .medium
        formatter.timeZone = TimeZone(identifier: settings.customTimeZone)!
        return formatter
    }
    
    @Published var islamicDate: (day: Int, month: String, year: String) = (1, "", "")
    @Published var fajrTime: Date = Date()
    @Published var sunriseTime: Date = Date()
    @Published var duhrTime: Date = Date()
    @Published var asrTime: Date = Date()
    @Published var maghribTime: Date = Date()
    @Published var ishaTime: Date = Date()
    @Published var midnightTime: Date = Date()
    @Published var tahajjudTime: Date = Date()
    
    func getIslamicDate() {
        var calendar = Calendar(identifier: .islamicUmmAlQura)
        calendar.timeZone = TimeZone(identifier: settings.customTimeZone)!
        
        let date = calendar.dateComponents([.year, .month, .day], from: Date())
        let islamicYear = String(date.year ?? 0).replacingOccurrences(of: ",", with: "")
        let islamicMonthNumber = date.month ?? 0
        let islamicDay = date.day ?? 0
        let islamicMonth = calendar.monthSymbols[islamicMonthNumber - 1]
        
        islamicDate = (day: islamicDay, month: islamicMonth, year: islamicYear)
    }
    
    func getPrayerTimes() {
        
        let latitude = settings.customLocationLatitude ?? 21.42250
        let longitude = settings.customLocationLongitude ?? 39.82621
        let calculationMethod = settings.calculationMethod
        let asrCalculation = settings.asrCalculation
        let timeZone = settings.customTimeZone
        
        let formatter = DateFormatter()
        formatter.timeStyle = .short
        formatter.timeZone = TimeZone(identifier: timeZone)!
        
        let cal = Calendar(identifier: Calendar.Identifier.gregorian)
        let date = cal.dateComponents([.year, .month, .day], from: Date())
        let coordinates = Coordinates(latitude: latitude, longitude: longitude)
        var params = calculationMethod.params
        params.madhab = asrCalculation
        
        if let prayers = PrayerTimes(coordinates: coordinates, date: date, calculationParameters: params) {
            fajrTime = prayers.fajr
            sunriseTime = prayers.sunrise
            duhrTime = prayers.dhuhr
            asrTime = prayers.asr
            maghribTime = prayers.maghrib
            ishaTime = prayers.isha
            
            if let sunnahs = SunnahTimes(from: prayers) {
                midnightTime = sunnahs.middleOfTheNight
                tahajjudTime = sunnahs.lastThirdOfTheNight
            }
        }
    }
    
    func playAthan(sound: String) {
        audioPlayer.audio = sound
        if settings.playDuaAfterAthan {
            audioPlayer.nextAudio = Sound.dua // Set the name of the next audio file here
        }
        audioPlayer.play()
    }
}
