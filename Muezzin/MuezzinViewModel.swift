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
    
    @Published var next: String = ""
    
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
        
        var cal = Calendar(identifier: .gregorian)
        cal.timeZone = TimeZone(identifier: settings.customTimeZone)!
        let date = cal.dateComponents([.year, .month, .day], from: Date())
        let coordinates = Coordinates(latitude: latitude, longitude: longitude)
        var params = calculationMethod.params
        params.madhab = asrCalculation
        
        if let prayers = PrayerTimes(coordinates: coordinates, date: date, calculationParameters: params) {
            fajr.time = prayers.fajr
            sunrise.time = prayers.sunrise
            duhr.time = prayers.dhuhr
            asr.time = prayers.asr
            maghrib.time = prayers.maghrib
            isha.time = prayers.isha
            
            switch prayers.nextPrayer() {
            case .fajr:
                next = "Fajr \(formatter.string(from: fajr.time))"
            case .sunrise:
                next = "Sunrise \(formatter.string(from: sunrise.time))"
            case .dhuhr:
                next = "Duhr \(formatter.string(from: duhr.time))"
            case .asr:
                next = "Asr \(formatter.string(from: asr.time))"
            case .maghrib:
                next = "Maghrib \(formatter.string(from: maghrib.time))"
            case .isha:
                next = "Isha \(formatter.string(from: isha.time))"
            case .none:
                next = "None"
            }
            
            if let sunnahs = SunnahTimes(from: prayers) {
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
        print("\(prayers[0]) - Fajr    - \(fajr.time)")
        print("\(prayers[1]) - Sunrise - \(sunrise.time)")
        print("\(prayers[2]) - Duhr    - \(duhr.time)")
        print("\(prayers[3]) - Asr     - \(asr.time)")
        print("\(prayers[4]) - Maghrib - \(maghrib.time)")
        print("\(prayers[5]) - Isha    - \(isha.time)")
        print("\(formatterMedium.string(from: Date())) - Current Time")
        print(next)
        
        
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
}
