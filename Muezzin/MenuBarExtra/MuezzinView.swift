//
//  MuezzinView.swift
//  Muezzin
//
//  Created by Mohamed Ali Boutaleb on 8/24/23.
//

import SwiftUI

struct MuezzinView: View {
    var body: some View {
        VStack(spacing: 12) {
            HStack(spacing: 12) {
                GroupBox {
                    DateView()
                }
                GroupBox {
                    ButtonsView()
                }
            }
            GroupBox {
                PrayerTimesView()
            }
            GroupBox {
                LocationNameView()
            }
        }
        .padding(12)
    }
}

#Preview {
    MuezzinView()
}
