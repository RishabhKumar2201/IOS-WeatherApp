//
//  realTimeWeatherView.swift
//  WeatherApp
//
//  Created by rentamac on 1/27/26.
//

import SwiftUI

struct realTimeWeatherView: View {
    
    let weather: WeatherResponse
    let location: Location
    
    var body: some View {
        VStack(spacing: 25) {
            Image(systemName: weatherCodeToIcon(weather.current.weatherCode))
                .resizable()
                .frame(width: 200, height: 200)
                .foregroundStyle(.yellow)
            
            Text("\(Int(weather.current.temperature2M))°C")
                .font(.largeTitle)
                .fontWeight(.bold)
                .foregroundStyle(.white)
            
            Text("Real-time weather")
                .font(.title2)
                .foregroundStyle(.gray)
            
            Spacer()
            
            WeatherInfoRowView(
                title1: "Wind Speed",
                value1: formattedWindSpeed(weather.current.windSpeed10M),
                title2: "Wind Direction",
                value2: "\(weather.current.windDirection10M)°"
            )
            .padding(.horizontal)
            
            WeatherInfoRowView(
                title1: "Cloud Cover",
                value1: "\(weather.current.cloudCover)%",
                title2: "Humidity",
                value2: "\(weather.current.relativeHumidity2M)%"
            )
            .padding(.horizontal)
            
            Spacer()
        }
    }
    
    private func formattedWindSpeed(_ speed: Double) -> String {
        String(format: "%.1f km/h", speed)
    }
    
    private func weatherCodeToIcon(_ code: Int) -> String {
        switch code {
        case 0, 1, 2, 3: return "sun.max.fill"
        case 45, 48: return "cloud.fog.fill"
        case 61, 63, 65: return "cloud.rain.fill"
        case 71, 73, 75, 77, 85, 86: return "snowflake"
        case 95...99: return "cloud.bolt.fill"
        default: return "cloud.fill"
        }
    }
}

