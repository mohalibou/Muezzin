//
//  MButton.swift
//  Muezzin
//
//  Created by Mohamed Ali Boutaleb on 4/19/23.
//

import SwiftUI

struct MButton: View {
    
    var icon: String
    var action: (() -> Void)
    
    @State private var opacity: Double = 0.45
    
    var body: some View {
        Button {
            action()
        } label: {
            Image(systemName: icon)
                .imageScale(.large)
                .frame(width: 30, height: 30)
                .background(Color.gray.opacity(opacity))
                .clipShape(Circle())
        }
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

struct MButton_Previews: PreviewProvider {
    static var previews: some View {
        MButton(icon: "person") {}
    }
}
