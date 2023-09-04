import Adhan
import Cocoa

var greeting = "Hello, playground"

var cal = Calendar(identifier: .gregorian)
let date = cal.dateComponents([.year, .month, .day], from: Date())

let newDate = cal.date(byAdding: .day, value: 1, to: Date()) ?? Date()
let date2 = cal.dateComponents([.year, .month, .day], from: newDate)


let coordinates = Coordinates(latitude: 37.760683, longitude: -121.893807)
var params = CalculationMethod.moonsightingCommittee.params
params.madhab = .hanafi

let formatter = DateFormatter()
formatter.timeStyle = .medium
formatter.timeZone = TimeZone(identifier: "America/Los_Angeles")!

let today = PrayerTimes(coordinates: coordinates, date: date, calculationParameters: params)



let tomorrow = PrayerTimes(coordinates: coordinates, date: date2, calculationParameters: params)

print("Fajr    \(formatter.string(from: today!.fajr))")
print("Sunrise \(formatter.string(from: today!.sunrise))")
print("Dhuhr   \(formatter.string(from: today!.dhuhr))")
print("Asr     \(formatter.string(from: today!.asr))")
print("Maghrib \(formatter.string(from: today!.maghrib))")
print("Isha    \(formatter.string(from: today!.isha))")
print("Fajr 2  \(formatter.string(from: tomorrow!.fajr))")
