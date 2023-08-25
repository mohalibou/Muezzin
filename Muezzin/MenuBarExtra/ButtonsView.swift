//
//  ButtonsView.swift
//  Muezzin
//
//  Created by Mohamed Ali Boutaleb on 4/19/23.
//

import SwiftUI

struct ButtonsView: View {
    
    @Environment(\.openWindow) var openWindow
    @Environment(\.dismiss) var dismiss
    
    var body: some View {
        VStack {
            HStack {
                SettingsLink().buttonStyle(MButtonStyle())
                MButton(icon: "calendar") { print("You pressed the Calendar button.") }
            }
            HStack {
                MButton(icon: "info.circle") { NSApp.activate(ignoringOtherApps: true); openWindow(id: "about") }
                MButton(icon: "power") { NSApplication.shared.terminate(self) }
            }
        }
        .frame(maxWidth: 83, maxHeight: .infinity)
    }
}

struct ButtonsView_Previews: PreviewProvider {
    static var previews: some View {
        ButtonsView()
    }
}
