//
//  WeatherResponse.swift
//  WeatherApp
//
//  Created by rentamac on 1/27/26.
//

import Foundation

// MARK: - WeatherResponse
struct WeatherResponse: Codable {
    let latitude, longitude, generationtimeMS: Double
    let utcOffsetSeconds: Int
    let timezone, timezoneAbbreviation: String
    let elevation: Double
    let currentUnits: CurrentUnits
    let current: Current

    enum CodingKeys: String, CodingKey {
        case latitude, longitude
        case generationtimeMS = "generationtime_ms"
        case utcOffsetSeconds = "utc_offset_seconds"
        case timezone
        case timezoneAbbreviation = "timezone_abbreviation"
        case elevation
        case currentUnits = "current_units"
        case current
    }
}

// MARK: - Current
struct Current: Codable {
    let time: String
    let interval: Int
    let temperature2M: Double
    let relativeHumidity2M: Int
    let windSpeed10M: Double
    let cloudCover: Int
    let windDirection10M: Int
    let weatherCode: Int

    enum CodingKeys: String, CodingKey {
        case time, interval
        case temperature2M = "temperature_2m"
        case relativeHumidity2M = "relative_humidity_2m"
        case windSpeed10M = "wind_speed_10m"
        case cloudCover = "cloud_cover"
        case windDirection10M = "wind_direction_10m"
        case weatherCode = "weather_code"
    }
}

// MARK: - CurrentUnits
struct CurrentUnits: Codable {
    let time, interval: String
    let temperature2M: String
    let relativeHumidity2M: String
    let windSpeed10M: String
    let cloudCover: String
    let windDirection10M: String
    let weatherCode: String

    enum CodingKeys: String, CodingKey {
        case time, interval
        case temperature2M = "temperature_2m"
        case relativeHumidity2M = "relative_humidity_2m"
        case windSpeed10M = "wind_speed_10m"
        case cloudCover = "cloud_cover"
        case windDirection10M = "wind_direction_10m"
        case weatherCode = "weather_code"     
    }
}
