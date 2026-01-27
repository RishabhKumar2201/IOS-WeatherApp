import SwiftUI

struct DetailView: View {
    let location: Location
    @State private var weatherResponse: WeatherResponse?
    @State private var isLoading = false
    @State private var error: Error?
    
    let weatherService: WeatherServiceProtocol
    
    var body: some View {
        NavigationStack {
            ZStack {
                Color("backgroundColor", bundle: nil).ignoresSafeArea()
                
                if isLoading {
                    ProgressView()
                        .progressViewStyle(CircularProgressViewStyle(tint: .white))
                } else if let error = error {
                    Text("Error: \(error.localizedDescription)")
                        .foregroundStyle(.white)
                        .padding()
                } else if let weather = weatherResponse {
                    realTimeWeatherView(weather: weather)
                } else {
                    originalStaticView()
                }
            }
//            .navigationBarBackButtonHidden(true)
            .toolbar {

                           ToolbarItem(placement: .principal) {
                               Text(location.name)  // ✅ Location name here - WHITE COLOR
                                   .foregroundStyle(.white)
                                   .font(.title2)
                                   .fontWeight(.semibold)
                           }
                       }
//            .navigationTitle("\(location.name)").frame(alignment: .center)
            .task {
                await fetchWeather()
            }
        }
    }
    
    private func fetchWeather() async {
        isLoading = true
        error = nil
        do {
            weatherResponse = try await weatherService.fetchWeather(
                latitude: location.latitude,
                longitude: location.longitude
            )
        } catch {
            self.error = error
        }
        isLoading = false
    }
    
    private func originalStaticView() -> some View {
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
    
    private func realTimeWeatherView(weather: WeatherResponse) -> some View {
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
            
            // ✅ Wind Info Row - EQUAL WIDTH CARDS
            weatherInfoRow(
                title1: "Wind Speed",
                value1: formattedWindSpeed(weather.current.windSpeed10M),
                title2: "Wind Direction",
                value2: "\(weather.current.windDirection10M)°"
            )
            .padding(.horizontal)
                        
            // ✅ Cloud & Humidity Row - EQUAL WIDTH CARDS
            weatherInfoRow(
                title1: "Cloud Cover",
                value1: "\(weather.current.cloudCover)%",
                title2: "Humidity",
                value2: "\(weather.current.relativeHumidity2M)%"
            )
            .padding(.horizontal)
            Spacer()
        }
    }
    
    // ✅ FIXED: Cards now have PERFECTLY EQUAL WIDTH
    private func weatherInfoRow(title1: String, value1: String, title2: String, value2: String) -> some View {
        HStack(spacing: 0) {  // spacing: 0 for perfect equal split
            // Left Card - Takes exactly 50% width
            weatherCard(title: title1, value: value1)
                .frame(maxWidth: .infinity)  // ✅ Equal width magic
            Spacer()
            Spacer()
            // Right Card - Takes exactly 50% width
            weatherCard(title: title2, value: value2)
                .frame(maxWidth: .infinity)  // ✅ Equal width magic
        }
    }
    
    // ✅ Reusable card component
    private func weatherCard(title: String, value: String) -> some View {
        VStack(spacing: 8) {
            Text(title)
                .font(.headline)
                .fontWeight(.semibold)
                .foregroundStyle(.white)
                .multilineTextAlignment(.center)

            Text(value)
                .font(.largeTitle)
                .fontWeight(.bold)
                .foregroundStyle(.white)
        }
        .padding(16)
        .frame(maxWidth: .infinity)  // ✅ Ensures equal width within HStack
        .background(.orange)
        .clipShape(RoundedRectangle(cornerRadius: 12))
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

#Preview {
    DetailView(
        location: Location(
            name: "Berlin",
            weather: .sunny,
            temperature: Temperature(min: 0, max: 5),
            latitude: 52.52,
            longitude: 13.42
        ),
        weatherService: WeatherService(networkService: HttpNetworking())
    )
}
