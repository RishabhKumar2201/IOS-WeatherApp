//
//  propertiesView.swift
//  WeatherApp
//
//  Created by rentamac on 1/27/26.
//

import SwiftUI

struct propertiesView: View {
    
    var weather: WeatherResponse?
    var unit: String?
    
    var body: some View {
        ZStack {
            Color(Color.blue).opacity(0.3)
            VStack {
                Text("\(weather?.current.windSpeed10M ?? 0.7)")
                    .font(.largeTitle)
                    .foregroundColor(.white)
                    .padding()
                
                Text("\(unit ?? "km/h")")
                    .font(.largeTitle)
                    .foregroundColor(.white)
            }
        }
    }
}

#Preview {
    propertiesView()
}
