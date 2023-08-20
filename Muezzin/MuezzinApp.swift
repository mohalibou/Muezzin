//
//  MuezzinApp.swift
//  Muezzin
//
//  Created by Mohamed Ali Boutaleb on 4/17/23.
//

import SwiftUIIntrospect
import SwiftUI

@main
struct MuezzinApp: App {
    var body: some Scene {
        MenuBarExtra {
            MuezzinView()
                .padding(12)
        } label: {
            HStack {
                let configuration = NSImage.SymbolConfiguration(pointSize: 16, weight: .light)
                    .applying(.init(hierarchicalColor: .red))
                
                let image = NSImage(systemSymbolName: "moon.stars.fill", accessibilityDescription: nil)
                let updateImage = image?.withSymbolConfiguration(configuration)
                
                let font = NSFont.systemFont(ofSize: 16, weight: .light)
                let color = NSColor.red
                let attributes: [NSAttributedString.Key: Any] = [
                    .font: font,
                    .foregroundColor: color
                ]

                let attributedString = NSAttributedString(string: "Hello, world!", attributes: attributes)
                

                Image(nsImage: updateImage!)
                Text(AttributedString(attributedString))
                
                /*
                 Image(systemName: "moon.stars.fill")
                 Text(" Muezzin")
                 */
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
