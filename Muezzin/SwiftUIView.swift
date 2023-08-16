//
//  SwiftUIView.swift
//  Muezzin
//
//  Created by Mohamed Ali Boutaleb on 4/27/23.
//

import SwiftUI

struct SwiftUIView: View {
    
    var moonSize: CGFloat = 260
    
    var body: some View {
        ZStack {
            Rectangle()
                .fill(Color.blue.gradient)
                .frame(width: 400, height: 400)
                .cornerRadius(66)
            Image(systemName: "moon.stars.fill")
                .scaledToFit()
                .font(.custom("", size: 300))
                .foregroundColor(.white)
                .font(Font.system(size: moonSize, weight: .ultraLight))
                .offset(x: -8, y: -8)
            /*
            
            Rectangle()
                .fill(Color.clear)
                .border(.green, width: 5)
                .frame(width: 250, height: 250)
             
            Rectangle()
                .fill(Color.red)
                .frame(width: 1000, height: 10)
                .rotationEffect(.degrees(-45))
             */
        }
    }
}

struct SwiftUIView_Previews: PreviewProvider {
    static var previews: some View {
        SwiftUIView()
    }
}
