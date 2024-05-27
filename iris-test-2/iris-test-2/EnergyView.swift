//
//  EnergyView.swift
//  iris-test-2
//
//  Created by Yinka Adepoju on 26/5/24.
//

import SwiftUI

struct EnergyView: View {
    @Binding var energyValue: Int // Binding to allow external control of energyValue
    var userImage: Image = Image("iris-uid") // Placeholder image for user
    var onTapped: () -> Void // Closure to handle tap action
    
    var body: some View {
        ZStack {
            HStack(spacing: 150) {
                // User image with grey stroke
                userImage
                    .resizable()
                    .scaledToFill()
                    .frame(width: 32, height: 32)
                    .clipShape(Circle())
                    .overlay(Circle().stroke(Color.gray, lineWidth: 2))
                
                // Plus icon
                Image("Plus")
                    .resizable()
                    .frame(width: 32, height: 32)
            }
            
            // Centered energy icon and text
            HStack(spacing: 10) {
                Image("Energy")
                    .resizable()
                    .frame(width: 20, height: 20)
                
                Text(formattedValue(energyValue))
                    .font(.custom("ABCGravity-XXCompressed", size: 36))
                    .foregroundColor(.black)
                    .baselineOffset(-5)
            }
            .offset(x: -5)
        }
        .padding(.horizontal, 14)
        .padding(.vertical, 2)
        .background(
            LinearGradient(
                gradient: Gradient(stops: [
                    .init(color: getEnergyColor(), location: 0),
                    .init(color: getEnergyColor(), location: percentageEnergyValue()),
                    .init(color: getEnergyColor().opacity(0.5), location: percentageEnergyValue()),
                    .init(color: getEnergyColor().opacity(0.5), location: 1.0)
                ]),
                startPoint: .leading,
                endPoint: .trailing
            )
        )
        .clipShape(Capsule())
        .frame(height: 50)
        .onTapGesture {
            onTapped() // Call the binding action
        }
    }
    
    // Function to format energy value for display
    private func formattedValue(_ value: Int) -> String {
        if value >= 1_000_000 {
            return "\(value / 1_000_000)M"
        } else if value >= 1_000 {
            return String(format: "%.1fK", Double(value) / 1_000.0)
        } else {
            return "\(value)"
        }
    }
    
    // Function to get color based on energy value
    private func getEnergyColor() -> Color {
        switch energyValue {
        case 0..<1500:
            return Color.red
        case 1500..<3000:
            return Color.orange
        case 3000..<6000:
            return Color.orange
        case 6000...:
            return Color(hex: "86FF4D")
        default:
            return Color.gray
        }
    }
    
    // Function to calculate percentage of energy value
    private func percentageEnergyValue() -> Double {
        let maxValue = 6000.0
        let percentage = Double(energyValue) / maxValue
        return percentage < 1.0 ? percentage : 1.0
    }
}

// Updated extension to use hex color values
extension Color {
    init(hex: String) {
        let scanner = Scanner(string: hex)
        var rgbValue: UInt64 = 0
        if scanner.scanHexInt64(&rgbValue) {
            let red = Double((rgbValue & 0xFF0000) >> 16) / 255.0
            let green = Double((rgbValue & 0x00FF00) >> 8) / 255.0
            let blue = Double(rgbValue & 0x0000FF) / 255.0
            self.init(red: red, green: green, blue: blue)
        } else {
            self.init(.clear)
        }
    }
}
