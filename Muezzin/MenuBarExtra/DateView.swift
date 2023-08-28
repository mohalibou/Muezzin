//
//  DateView.swift
//  Muezzin
//
//  Created by Mohamed Ali Boutaleb on 8/24/23.
//

import SwiftUI

struct DateView: View {
    
    @StateObject private var settings = AppSettings.shared
    @EnvironmentObject var vm: MuezzinViewModel
    
    var body: some View {
        HStack {
            Text(String(vm.islamicDate.day))
                .font(.system(size: 60, weight: .thin))
                .padding(.trailing, 5)
                .minimumScaleFactor(0.01)
                .lineLimit(1)
            VStack(alignment: .leading, spacing: 10) {
                Text(vm.islamicDate.month)
                Text("\(vm.islamicDate.year) AH")
            }
            Spacer()
        }
        .padding(6)
        .frame(maxWidth: .infinity, minHeight: 80)
        .onAppear { vm.getIslamicDate() }
        .onReceive(Timer.publish(every: 0.1, on: .main, in: .common).autoconnect()) { _ in
            vm.getIslamicDate()
        }
        
    }
}

#Preview {
    DateView()
}


/*
 
 HStack {
             Text("\(islamicDate.day)")
                 .font(.system(size: 60, weight: .thin))
                 .padding(.trailing, 5)
                 .minimumScaleFactor(0.01)
                 .lineLimit(1)
             VStack(alignment: .leading, spacing: 10) {
                 Text(islamicDate.month)
                 Text("\(islamicDate.year) AH")
             }
             Spacer()
         }
 
 */
