//
//  MuezzinViewModel.swift
//  Muezzin
//
//  Created by Mohamed Ali Boutaleb on 4/28/23.
//

import Adhan
import CoreLocation

final class MuezzinViewModel: ObservableObject {
    
    let date = Calendar(identifier: Calendar.Identifier.gregorian)
        .dateComponents([.year, .month, .day], from: Date())
    
    func getTodayPrayerTimes(coords: CLLocation, calcMethod: CalculationMethod, madhab: Madhab, timeZone: String) -> [String] {
        
        let coordinates = Coordinates(latitude: coords.coordinate.latitude, longitude: coords.coordinate.longitude)
        var params = calcMethod.params
        params.madhab = madhab
        
        let formatter = DateFormatter()
        formatter.timeStyle = .short
        formatter.timeZone = TimeZone(identifier: timeZone)!
        
        if let prayers = PrayerTimes(coordinates: coordinates, date: date, calculationParameters: params) {
            return [
                formatter.string(from: prayers.fajr),
                formatter.string(from: prayers.dhuhr),
                formatter.string(from: prayers.asr),
                formatter.string(from: prayers.maghrib),
                formatter.string(from: prayers.isha),
            ]
        }
        
        return []
        
    }
    
}
