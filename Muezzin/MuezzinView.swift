//
//  MuezzinView.swift
//  Muezzin
//
//  Created by Mohamed Ali Boutaleb on 4/19/23.
//

import SwiftUI

struct MuezzinView: View {
    var body: some View {
        HStack(spacing: 12) {
            GroupBox {
                DateView()
            }
            GroupBox {
                ButtonsView()
            }
        }
        .padding(.bottom, 4)
        GroupBox {
            PrayerTimesView()
        }
    }
}

struct MuezzinView_Previews: PreviewProvider {
    static var previews: some View {
        MuezzinView()
    }
}
