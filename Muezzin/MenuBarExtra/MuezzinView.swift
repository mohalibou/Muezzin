//
//  MuezzinView.swift
//  Muezzin
//
//  Created by Mohamed Ali Boutaleb on 4/19/23.
//

import SwiftUI

struct MuezzinView: View {
    
    @StateObject private var vm = MuezzinViewModel()
    
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
                PrayerTimesView(vm: vm)
            }
            GroupBox {
                NextPrayerView()
            }
        }
        .padding(12)
    }
}

struct MuezzinView_Previews: PreviewProvider {
    static var previews: some View {
        MuezzinView()
    }
}
