//
//  WeatherEndpoint.swift
//  WeatherApp
//
//  Created by rentamac on 1/27/26.
//

import Foundation

struct WeatherEndpoint : ApiEndpoint {
    
    let request: WeatherRequest
    
    var baseURL: String {
        "https://api.open-meteo.com"
    }
    
    var path: String {
        "/v1/forecast"
    }
    
    var queryItems: [URLQueryItem] {
        [
            URLQueryItem(name: "latitude", value: "\(request.latitude)"),
            URLQueryItem(name: "longitude", value: "\(request.longitude)"),
            URLQueryItem(name: "current", value: "temperature_2m,weather_code")            
        ]
    }
}
