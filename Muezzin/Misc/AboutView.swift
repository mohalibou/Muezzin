//
//  AboutView.swift
//  Muezzin
//
//  Created by Mohamed Ali Boutaleb on 8/24/23.
//

import SwiftUI

struct AboutView: View {
    var body: some View {
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
}

#Preview {
    AboutView()
}
