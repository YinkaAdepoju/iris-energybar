//
//  ContentView.swift
//  iris-test-2
//
//  Created by Yinka Adepoju on 26/5/24.
//

import SwiftUI

struct ContentView: View {
    @State private var energyValue = 0
    
    var body: some View {
        VStack {
            Spacer()
            EnergyView(energyValue: $energyValue, onTapped: {
                // Define your custom action here
                energyValue += 500 // Example action
            })
            Spacer()
        }
        .padding()
        .background(Color.clear) // Background color for the entire view
        .edgesIgnoringSafeArea(.all)
    }
}
