//
//  MuezzinViewModel.swift
//  Muezzin
//
//  Created by Mohamed Ali Boutaleb on 8/25/23.
//

import Adhan
import SwiftUI

class MuezzinViewModel: ObservableObject {
    
    @Published var audioPlayer = AudioPlayer()
    @Published var islamicDate = (day: "", month: "", year: "")
    
    @Published var fajr = (time: Date(), isItTime: false)
    @Published var sunrise = (time: Date(), isItTime: false)
    @Published var duhr = (time: Date(), isItTime: false)
    @Published var asr = (time: Date(), isItTime: false)
    @Published var maghrib = (time: Date(), isItTime: false)
    @Published var isha = (time: Date(), isItTime: false)
    @Published var tomorrowFajr = (time: Date(), isItTime: false)
    
    @Published var next = (icon: "", time: "")
    
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
            
            fajr.time = todaysPrayers.fajr
            sunrise.time = todaysPrayers.sunrise
            duhr.time = todaysPrayers.dhuhr
            asr.time = todaysPrayers.asr
            maghrib.time = todaysPrayers.maghrib
            isha.time = todaysPrayers.isha
            tomorrowFajr.time = tomorrowsPrayers.fajr
            
            let nextPrayer = todaysPrayers.nextPrayer()
            let countdown = todaysPrayers.time(for: nextPrayer!)
            
            switch nextPrayer {
            case .fajr:
                next.icon = "light.max"
                next.time = "\(formatPrayerName("Isha")) \(formatPrayerTime(fajr.time, countdown))"
            case .sunrise:
                next.icon = "sunrise.fill"
                next.time = "\(formatPrayerName("Sunrise")) \(formatPrayerTime(sunrise.time, countdown))"
            case .dhuhr:
                next.icon = "sun.max.fill"
                next.time = "\(formatPrayerName("Duhr")) \(formatPrayerTime(duhr.time, countdown))"
            case .asr:
                next.icon = "sun.min.fill"
                next.time = "\(formatPrayerName("Asr")) \(formatPrayerTime(asr.time, countdown))"
            case .maghrib:
                next.icon = "sunset.fill"
                next.time = "\(formatPrayerName("Maghrib")) \(formatPrayerTime(maghrib.time, countdown))"
            case .isha:
                next.icon = "moon.stars.fill"
                next.time = "\(formatPrayerName("Isha")) \(formatPrayerTime(isha.time, countdown))"
            case .none:
                next.icon = "light.max"
                next.time = "\(formatPrayerName("Fajr")) \(formatPrayerTime(tomorrowFajr.time, countdown))"
            }
            
            if let sunnahs = SunnahTimes(from: todaysPrayers) {
                //midnightTime = sunnahs.middleOfTheNight
                //tahajjudTime = sunnahs.lastThirdOfTheNight
            }
        }
        
    }
    
    func checkIfItsTime() {
        
        let prayers = [formatterMedium.string(from: fajr.time),
                       formatterMedium.string(from: sunrise.time),
                       formatterMedium.string(from: duhr.time),
                       formatterMedium.string(from: asr.time),
                       formatterMedium.string(from: maghrib.time),
                       formatterMedium.string(from: isha.time)]
        
        let currentTime = Date().formatted(date: .omitted, time: .standard)
        
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
                fajr.isItTime = true
                if settings.fajrAthan != Sound.none {
                    playAthan(sound: settings.fajrAthan)
                } else {
                    fajr.isItTime = false
                }
            case 1:
                print("It's time for Sunrise.")
                sunrise.isItTime = true
                sunrise.isItTime = false
            case 2:
                print("It's time for Duhr.")
                duhr.isItTime = true
                if settings.duhrAthan != Sound.none {
                    playAthan(sound: settings.duhrAthan)
                } else {
                    duhr.isItTime = false
                }
            case 3:
                print("It's time for Asr.")
                asr.isItTime = true
                if settings.asrAthan != Sound.none {
                    playAthan(sound: settings.asrAthan)
                } else {
                    asr.isItTime = false
                }
            case 4:
                print("It's time for Maghrib.")
                maghrib.isItTime = true
                if settings.maghribAthan != Sound.none {
                    playAthan(sound: settings.maghribAthan)
                } else {
                    maghrib.isItTime = false
                }
            case 5:
                print("It's time for Isha.")
                isha.isItTime = true
                if settings.ishaAthan != Sound.none {
                    playAthan(sound: settings.ishaAthan)
                } else {
                    isha.isItTime = false
                }
            default:
                print("Unknown prayer time.")
            }
        }
    }
    
    func getMonthlyTimes() {
        
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
