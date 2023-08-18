//
//  SettingsGeneralView.swift
//  Muezzin
//
//  Created by Mohamed Ali Boutaleb on 8/17/23.
//

import SwiftUI

struct SettingsGeneralView: View {
    
    @State private var flag2 = false
    
    var body: some View {
        Form {
            Section {
                Toggle("Display next prayer in menu bar", isOn: $flag2)
                Group {
                    Text("Hello")
                    Text("Hello")
                }
            }
        }
        .formStyle(.grouped)
    }
}

