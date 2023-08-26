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
    
    var body: some Scene {
        MenuBarExtra {
            MuezzinView()
        } label: {
            menuBarLabel
        }
        .menuBarExtraStyle(.window)
        
        Settings {
            SettingsView()
        }
        
        Window("", id: "about") {
            AboutView()
        }
        .windowResizability(.contentSize)
    }
    
    var menuBarLabel: some View {
        HStack {
            if settings.displayIcon {
                Image(systemName: "person")
            }
            if settings.displayNextPrayer {
                Text("Hello")
            }
        }
    }
}
