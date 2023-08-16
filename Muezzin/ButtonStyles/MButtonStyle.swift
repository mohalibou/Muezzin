//
//  MButtonStyle.swift
//  Muezzin
//
//  Created by Mohamed Ali Boutaleb on 8/16/23.
//

import SwiftUI

struct MButtonStyle: ButtonStyle {
    
    @State private var opacity: Double = 0.45
    
    func makeBody(configuration: Configuration) -> some View {
        configuration.label
            .imageScale(.large)
            .labelStyle(.iconOnly)
            .frame(width: 30, height: 30)
            .background(Color.gray.opacity(opacity))
            .clipShape(Circle())
            .buttonStyle(.plain)
            .padding(3)
            .onHover { inside in
                if inside {
                    opacity = 0.65
                } else {
                    opacity = 0.45
                }
            }
    }
}
