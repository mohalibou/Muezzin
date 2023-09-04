//
//  MuezzinApp.swift
//  Muezzin
//
//  Created by Mohamed Ali Boutaleb on 4/17/23.
//

import SwiftUI

@main
struct MuezzinApp: App {
    
    @StateObject private var vm = MuezzinViewModel()
    
    let timer1 = Timer.publish(every: 1, on: .main, in: .common).autoconnect()
    let timer2 = Timer.publish(every: 0.1, on: .main, in: .common).autoconnect()
    
    var body: some Scene {
        MenuBarExtra {
            MuezzinView()
                .environmentObject(vm)
                
        } label: {
            menuBarLabel
                .onReceive(timer1) { _ in
                    vm.checkIfItsTime()
                }
                .onReceive(timer2) { _ in
                    vm.getIslamicDate()
                    vm.getPrayerTimes()
                }
        }
        .menuBarExtraStyle(.window)
        
        Settings {
            SettingsView()
                .environmentObject(vm)
        }
        
        Window("", id: "about") {
            AboutView()
        }
        .windowResizability(.contentSize)
    }
    
    var menuBarLabel: some View {
        HStack {
            Image(systemName: vm.next.icon)
            Text(vm.next.time)
        }
    }
}
