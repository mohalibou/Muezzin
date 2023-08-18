//
//  DateView.swift
//  Muezzin
//
//  Created by Mohamed Ali Boutaleb on 4/19/23.
//

import SwiftUI

struct DateView: View {
    let cal: Calendar
    @State private var currentDate = Date()
    private let timer = Timer.publish(every: 1, on: .main, in: .common).autoconnect()

    init() {
        var calendar = Calendar(identifier: .islamicUmmAlQura)
        calendar.timeZone = TimeZone(identifier: "America/Los_Angeles")! // Replace with your desired time zone identifier
        self.cal = calendar
    }

    var islamicDate: (day: Int, month: String, year: String) {
        let date = cal.dateComponents([.year, .month, .day], from: currentDate)
        let islamicYear = String(date.year ?? 0).replacingOccurrences(of: ",", with: "")
        let islamicMonthNumber = date.month ?? 0
        let islamicDay = date.day ?? 0
        let islamicMonth = cal.monthSymbols[islamicMonthNumber - 1]
        return (day: islamicDay, month: islamicMonth, year: islamicYear)
    }

    var body: some View {
        HStack {
            Text("\(islamicDate.day)")
                .font(.system(size: 60, weight: .thin))
                .padding(.trailing, 5)
                .minimumScaleFactor(0.01)
                .lineLimit(1)
            VStack(alignment: .leading, spacing: 10) {
                Text(islamicDate.month)
                Text("\(islamicDate.year) AH")
            }
            Spacer()
        }
        .padding(6)
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .onReceive(timer) { _ in
            self.currentDate = Date()
        }
    }
}

struct DateView_Previews: PreviewProvider {
    static var previews: some View {
        DateView()
    }
}
