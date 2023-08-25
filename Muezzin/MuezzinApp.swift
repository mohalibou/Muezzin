//
//  MuezzinApp.swift
//  Muezzin
//
//  Created by Mohamed Ali Boutaleb on 4/17/23.
//

import SwiftUI

@main
struct MuezzinApp: App {
    var body: some Scene {
        MenuBarExtra {
            MuezzinView()
        } label: {
            HStack {
                Image(systemName: "person")
                Text("Hello")
            }
        }
        .menuBarExtraStyle(.window)
        
        Settings {
            SettingsView()
        }
        
        
        Window("", id: "about") {
            VStack {
                Text("Hello")
            }
            .frame(width: 284, height: 100)
            .onReceive(NotificationCenter.default.publisher(for: NSApplication.willUpdateNotification), perform: { _ in
                for window in NSApplication.shared.windows {
                    window.standardWindowButton(.miniaturizeButton)?.isEnabled = false
                    window.standardWindowButton(.zoomButton)?.isEnabled = false
                }
            })
        }
        .windowResizability(.contentSize)
    }
}

/*
 HStack {
 let configuration = NSImage.SymbolConfiguration(pointSize: 16, weight: .light)
 .applying(.init(hierarchicalColor: .red))
 
 let image = NSImage(systemSymbolName: "moon.stars.fill", accessibilityDescription: nil)!
 .withSymbolConfiguration(configuration)
 
 let attributedText = NSAttributedString(string: "Muezzin", attributes: [.foregroundColor: Color.green])
 
 let myString = " Fajr 4:54"
 let myAttribute = [ NSAttributedString.Key.foregroundColor: NSColor.blue ]
 let myAttrString = NSAttributedString(string: myString, attributes: myAttribute)
 
 Label {
 Text(AttributedString(myAttrString)).foregroundStyle(.red, .green)
 } icon: {
 Image(nsImage: image!)
 }
 .labelStyle(.titleAndIcon)
 
 }*/
