//
//  ButtonsView.swift
//  Muezzin
//
//  Created by Mohamed Ali Boutaleb on 8/24/23.
//

import SwiftUI

struct ButtonsView: View {
    var body: some View {
        LazyVGrid(columns: [GridItem](repeating: GridItem(.flexible(), spacing: 4), count: 2), spacing: 4) {
            SettingsLink().buttonStyle(MButtonStyle())
            MButton(icon: "calendar") { print("You have pressed the calendar button.") }
            MButton(icon: "info.circle") { print("You have pressed the about button.") }
            MButton(icon: "power") { print("You have pressed the power button.") }
        }
        .padding(4)
        .frame(width: 80, height: 80)
    }
}

#Preview {
    ButtonsView()
}
