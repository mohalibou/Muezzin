//
//  NextPrayerView.swift
//  Muezzin
//
//  Created by Mohamed Ali Boutaleb on 8/24/23.
//

import SwiftUI

struct NextPrayerView: View {
    var body: some View {
        VStack {
            AttributedText(menubarStringValue: "example")
        }
        .frame(maxWidth: .infinity)
    }
}

#Preview {
    NextPrayerView()
}

struct AttributedText: NSViewRepresentable {
    
    var menubarStringValue: String
    
    func makeNSView(context: Context) -> NSTextField {
        let textField = NSTextField()
        textField.isEditable = false
        textField.isBordered = false
        textField.backgroundColor = .clear
        return textField
    }
    
    func updateNSView(_ nsView: NSTextField, context: Context) {
        if #available(OSX 10.15, *) {
            let attributes = [NSAttributedString.Key.font: NSFont.monospacedSystemFont(ofSize: 12, weight: .medium)]
            let attrString = NSAttributedString(string: menubarStringValue, attributes: attributes)
            nsView.attributedStringValue = attrString
        } else {
            let attributes = [NSAttributedString.Key.font: NSFont(name: "Monaco", size: 12) ?? NSFont.systemFont(ofSize: 12)]
            let attrString = NSAttributedString(string: menubarStringValue, attributes: attributes)
            nsView.attributedStringValue = attrString
        }
    }
}
