//
//  LocationNameView.swift
//  Muezzin
//
//  Created by Mohamed Ali Boutaleb on 9/6/23.
//

import SwiftUI

struct LocationNameView: View {
    
    @EnvironmentObject var vm: MuezzinViewModel
    @StateObject private var settings = AppSettings.shared
    
    var body: some View {
        Label(vm.location, systemImage: "location.fill")
            .frame(maxWidth: .infinity)
            .onAppear {
                vm.getLocationName()
            }
            .onChange(of: settings.customLocationLatitude) {
                vm.getLocationName()
            }
            .onChange(of: settings.customLocationLongitude) {
                vm.getLocationName()
            }
    }
}

#Preview {
    LocationNameView()
}
