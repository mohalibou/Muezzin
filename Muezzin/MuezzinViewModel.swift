//
//  MuezzinViewModel.swift
//  Muezzin
//
//  Created by Mohamed Ali Boutaleb on 8/25/23.
//

import Adhan
import CoreLocation
import SwiftUI

class MuezzinViewModel: ObservableObject {
    
    @Published var audioPlayer = AudioPlayer()
    @Published var islamicDate = (day: "", month: "", year: "")
    
    @Published var fajrTime = Date()
    @Published var sunriseTime = Date()
    @Published var duhrTime = Date()
    @Published var asrTime = Date()
    @Published var maghribTime = Date()
    @Published var ishaTime = Date()
    @Published var tomorrowFajrTime = Date()
    
    @Published var location = ""
    
    @Published var whichPrayerIsItTimeFor: String = ""
    @Published var current: Prayer = .fajr
    @Published var next: (icon: String, time: String) = ("", "")
    
    
    var settings = AppSettings.shared
    
    var formatter: DateFormatter {
        let formatter = DateFormatter()
        formatter.timeStyle = .short
        formatter.timeZone = TimeZone(identifier: settings.customTimeZone)!
        return formatter
    }
    
    private var formatterMedium: DateFormatter {
        let formatter = DateFormatter()
        formatter.timeStyle = .medium
        formatter.timeZone = TimeZone(identifier: settings.customTimeZone)!
        return formatter
    }
    
    func getIslamicDate() {
        var calendar = Calendar(identifier: .islamicUmmAlQura)
        calendar.timeZone = TimeZone(identifier: settings.customTimeZone)!
        
        let date = calendar.dateComponents([.year, .month, .day], from: Date())
        let islamicYear = String(date.year ?? 0).replacingOccurrences(of: ",", with: "")
        let islamicMonthNumber = date.month ?? 0
        let islamicDay = String(date.day ?? 0)
        let islamicMonth = calendar.monthSymbols[islamicMonthNumber - 1]
        
        islamicDate = (day: islamicDay, month: islamicMonth, year: islamicYear)
    }
    
    func getPrayerTimes() {
        let latitude = settings.customLocationLatitude
        let longitude = settings.customLocationLongitude
        let calculationMethod = settings.calculationMethod
        let asrCalculation = settings.asrCalculation
        
        let cal = Calendar(identifier: .gregorian)
        let today = cal.dateComponents([.year, .month, .day], from: Date())
        
        let nextDay = cal.date(byAdding: .day, value: 1, to: Date()) ?? Date()
        let tomorrow = cal.dateComponents([.year, .month, .day], from: nextDay)
        
        let coords = Coordinates(latitude: latitude, longitude: longitude)
        var params = calculationMethod.params
        params.madhab = asrCalculation
        
        if let todaysPrayers = PrayerTimes(coordinates: coords, date: today, calculationParameters: params), 
            let tomorrowsPrayers = PrayerTimes(coordinates: coords, date: tomorrow, calculationParameters: params) {
            
            fajrTime = todaysPrayers.fajr
            sunriseTime = todaysPrayers.sunrise
            duhrTime = todaysPrayers.dhuhr
            asrTime = todaysPrayers.asr
            maghribTime = todaysPrayers.maghrib
            ishaTime = todaysPrayers.isha
            tomorrowFajrTime = tomorrowsPrayers.fajr
            
            current = todaysPrayers.currentPrayer()!
            
            let nextPrayer = todaysPrayers.nextPrayer()
            let countdown = todaysPrayers.time(for: nextPrayer ?? .dhuhr)
            
            switch nextPrayer {
            case .fajr:
                next.icon = "light.max"
                next.time = "\(formatPrayerName("Isha")) \(formatPrayerTime(fajrTime, countdown))"
            case .sunrise:
                next.icon = "sunrise.fill"
                next.time = "\(formatPrayerName("Sunrise")) \(formatPrayerTime(sunriseTime, countdown))"
            case .dhuhr:
                next.icon = "sun.max.fill"
                next.time = "\(formatPrayerName("Duhr")) \(formatPrayerTime(duhrTime, countdown))"
            case .asr:
                next.icon = "sun.min.fill"
                next.time = "\(formatPrayerName("Asr")) \(formatPrayerTime(asrTime, countdown))"
            case .maghrib:
                next.icon = "sunset.fill"
                next.time = "\(formatPrayerName("Maghrib")) \(formatPrayerTime(maghribTime, countdown))"
            case .isha:
                next.icon = "moon.stars.fill"
                next.time = "\(formatPrayerName("Isha")) \(formatPrayerTime(ishaTime, countdown))"
            case .none:
                next.icon = "light.max"
                next.time = "\(formatPrayerName("Fajr")) \(formatPrayerTime(tomorrowFajrTime, countdown))"
            }
            
            if let sunnahs = SunnahTimes(from: todaysPrayers) {
                //midnightTime = sunnahs.middleOfTheNight
                //tahajjudTime = sunnahs.lastThirdOfTheNight
            }
        }
        
    }
    
    func checkIfItsTime() {
        
        let prayers = [formatterMedium.string(from: fajrTime),
                       formatterMedium.string(from: sunriseTime),
                       formatterMedium.string(from: duhrTime),
                       formatterMedium.string(from: asrTime),
                       formatterMedium.string(from: maghribTime),
                       formatterMedium.string(from: ishaTime)]
        
        let currentTime = formatterMedium.string(from: Date())
        
        print("------------------------")
        print("\(prayers[0]) - Fajr")
        print("\(prayers[1]) - Sunrise")
        print("\(prayers[2]) - Duhr")
        print("\(prayers[3]) - Asr")
        print("\(prayers[4]) - Maghrib")
        print("\(prayers[5]) - Isha")
        print("\(formatterMedium.string(from: Date())) - Current Time")
        print(next.time)
        
        
        if let index = prayers.firstIndex(of: currentTime) {
            switch index {
            case 0:
                print("It's time for Fajr.")
                whichPrayerIsItTimeFor = "Fajr"
                if settings.fajrAthan != Sound.none && !settings.silentMode {
                    playAthan(sound: settings.fajrAthan)
                }
            case 1:
                print("It's time for Sunrise.")
            case 2:
                print("It's time for Duhr.")
                whichPrayerIsItTimeFor = "Duhr"
                if settings.duhrAthan != Sound.none && !settings.silentMode {
                    playAthan(sound: settings.duhrAthan)
                }
            case 3:
                print("It's time for Asr.")
                whichPrayerIsItTimeFor = "Asr"
                if settings.asrAthan != Sound.none && !settings.silentMode {
                    playAthan(sound: settings.asrAthan)
                }
            case 4:
                print("It's time for Maghrib.")
                whichPrayerIsItTimeFor = "Maghrib"
                if settings.maghribAthan != Sound.none && !settings.silentMode {
                    playAthan(sound: settings.maghribAthan)
                }
            case 5:
                print("It's time for Isha.")
                whichPrayerIsItTimeFor = "Isha"
                if settings.ishaAthan != Sound.none && !settings.silentMode {
                    playAthan(sound: settings.ishaAthan)
                }
            default:
                print("Unknown prayer time.")
            }
        }
    }
    
    func getMonthlyTimes() {
        
    }
    
    func getLocationName() {
        let locationToGeocode = CLLocation(latitude: settings.customLocationLatitude, longitude: settings.customLocationLongitude)
        let geocoder = CLGeocoder()
        geocoder.reverseGeocodeLocation(locationToGeocode) { (placemarks, error) in
            if let placemark = placemarks?.first, let city = placemark.locality, let state = placemark.administrativeArea {
                self.location = city == state ? "\(city)" : "\(city), \(state)"
            } else if let placemark = placemarks?.first, let state = placemark.administrativeArea {
                self.location = "\(state)"
            } else {
                self.location = "Unknown"
            }
        }
    }
    
    private func playAthan(sound: Sound) {
        audioPlayer.audio = sound
        audioPlayer.play()
        if settings.playDuaAfterAthan {
            audioPlayer.nextAudio = Sound.dua
        }
    }
    
    func stopAthan() {
        audioPlayer.stop()
    }
    
    private func formatPrayerName(_ name: String) -> String {
        if settings.prayerName == .full {
            return name
        } else if settings.prayerName == .abbreviation {
            return String(name.first!)
        } else {
            return ""
        }
    }
    
    private func formatPrayerTime(_ time: Date, _ countdown: Date) -> String {
        if settings.prayerTime == .time {
            return formatter.string(from: time)
        } else if settings.prayerTime == .countdown {
            let timeRemaining = Date().distance(to: countdown)
            let hours = Int(timeRemaining) / 3600
            let minutes = (Int(timeRemaining) % 3600 + 60) / 60
            return "-\(String(format: "%02d:%02d", hours, minutes))"
        } else {
            return ""
        }
    }
}
