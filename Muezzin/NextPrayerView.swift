//
//  NextPrayerView.swift
//  Muezzin
//
//  Created by Mohamed Ali Boutaleb on 8/23/23.
//

import SwiftUI

struct NextPrayerView: View {
    
    @EnvironmentObject private var locationManager: LocationManager
    
    var body: some View {
        VStack(spacing: 4) {
            HStack(alignment: .bottom) {
                Text("Asr").font(.title).offset(x: 2, y: 4)
                Spacer()
                Text("11 min, 19 sec left")
            }
            Gauge(value: 5, in: 1...10) { }
                .gaugeStyle(.accessoryLinearCapacity)
            Label(locationManager.locationName, systemImage: "location.fill")
                .foregroundStyle(.secondary)
                .padding(.bottom, 4)
        }
        .padding(.horizontal, 6)
        .frame(maxWidth: .infinity)
    }
}

#Preview {
    NextPrayerView()
}
