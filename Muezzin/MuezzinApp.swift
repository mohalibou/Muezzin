//
//  MuezzinApp.swift
//  Muezzin
//
//  Created by Mohamed Ali Boutaleb on 4/17/23.
//

import SwiftUI

@main
struct MuezzinApp: App {
    
    @StateObject private var settings = AppSettings.shared
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
            let configuration = NSImage.SymbolConfiguration(pointSize: 16, weight: .light)
                .applying(.init(hierarchicalColor: .red))
            
            let image = NSImage(systemSymbolName: vm.next.icon, accessibilityDescription: nil)
            let updateImage = image?.withSymbolConfiguration(configuration)
            
            //Image(nsImage: updateImage!)
            
            if settings.displayIcon {
                Image(systemName: vm.next.icon)
            }
            if settings.displayNextPrayer {
                Text(vm.next.time)
            }
            
            //AttributedText(menubarStringValue: "Hello")
        }
    }
}

