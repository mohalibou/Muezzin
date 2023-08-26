//
//  MTimeZonePicker.swift
//  Muezzin
//
//  Created by Mohamed Ali Boutaleb on 8/25/23.
//

import SwiftUI

struct MTimeZonePicker: View {
    
    @Binding var timeZone: String
    
    var sortedTimeZoneIdentifiers: [String] {
        TimeZone.knownTimeZoneIdentifiers.sorted {
            formatTimeZoneIdentifier($0) < formatTimeZoneIdentifier($1)
        }
    }
    
    var body: some View {
        Picker("Time zone", selection: $timeZone) {
            ForEach(sortedTimeZoneIdentifiers, id: \.self) { timeZoneIdentifier in
                Text(formatTimeZoneIdentifier(timeZoneIdentifier)).tag(timeZoneIdentifier)
            }
        }
    }
    
    func formatTimeZoneIdentifier(_ identifier: String) -> String {
        let components = identifier.split(separator: "/")
        return components.last?.replacingOccurrences(of: "_", with: " ") ?? identifier
    }
}
