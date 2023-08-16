//
//  PrayerTimesCell.swift
//  Muezzin
//
//  Created by Mohamed Ali Boutaleb on 4/19/23.
//

import SwiftUI

struct PrayerTimesCell: View {
    
    @State private var isHovering = false
    
    var name: String
    var time: String
    var image: String
    var notification: String
    
    var notificationIcons: [String] = ["bell.slash", "bell.fill", "megaphone.fill"]
    
    var body: some View {
        HStack {
            Label {
                Text(name)
            } icon: {
                Image(systemName: image)
                    .scaledToFit()
                    .frame(width: 20)
            }
            Spacer()
            Text(time)
            
            if (isHovering) {
                Image(systemName: notification)
                    .scaledToFit()
                    .frame(width: 20)
                    .symbolRenderingMode(.palette)
                    .foregroundStyle(notification == "bell.slash" ? .red : .white, .white)
            }
            
        }
        .font(.title3)
        .padding(.horizontal, 6)
        .padding(.vertical, 2)
        .onHover { hovering in
            withAnimation {
                isHovering = hovering
            }
        }
    }
}

struct PrayerTimesCell_Previews: PreviewProvider {
    static var previews: some View {
        PrayerTimesCell(name: "Isha", time: "9:00 PM", image: "person", notification: "person")
    }
}
