//
//  MuezzinLabel.swift
//  Muezzin
//
//  Created by Mohamed Ali Boutaleb on 8/19/23.
//

import SwiftUI

struct MuezzinLabel: NSViewControllerRepresentable {
    func makeNSViewController(context: Context) -> NSViewController {
        let viewController = MuezzinViewController()
        return viewController
    }
    
    func updateNSViewController(_ nsViewController: NSViewController, context: Context) {
        
    }
}

class MuezzinViewController: NSViewController {
    
}
