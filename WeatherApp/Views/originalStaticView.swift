//
//  originalStaticView.swift
//  WeatherApp
//
//  Created by rentamac on 1/27/26.
//

import SwiftUI

struct originalStaticView: View {
    
    var location: Location
        
    
    var body: some View {
        VStack(spacing: 20) {
            Image(systemName: location.weather.icon)
                .resizable()
                .frame(width: 200, height: 200)
                .foregroundStyle(.yellow)
            
            Text(location.temperature.temperatureText)
                .font(.title)
                .foregroundStyle(.gray)
            
            Spacer()
            HStack {
                Text("A warm breeze drifted through the streets...")
                    .font(.title3)
                    .foregroundStyle(.white)
                    .padding()
            }
            Spacer()
        }
    }
}


