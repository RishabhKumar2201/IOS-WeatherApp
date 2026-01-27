import SwiftUI
struct DetailView: View {
    
    let location: Location
    let weatherService: WeatherServiceProtocol
    
    @State private var weatherResponse: WeatherResponse?
    @State private var isLoading = false
    @State private var error: Error?
    
    var body: some View {
        NavigationStack {
            ZStack {
                Color("backgroundColor", bundle: nil)
                    .ignoresSafeArea()
                
               
                if isLoading {
                    ProgressView()
                        .progressViewStyle(CircularProgressViewStyle(tint: .white))
                        .foregroundColor(.white)
                } else if let error = error {
                    Text("Error: \(error.localizedDescription)")
                        .foregroundColor(.white)
                        .padding()
                } else if let weather = weatherResponse {
                
                    realTimeWeatherView(weather: weather)
                       
                } else {
              
                    originalStaticView()
                }
            }
//            .padding(25)
            .frame(alignment: .center)
//            .navigationTitle(location.name)
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
            print("Weather fetch failed: \(error)")  // Debug log
        }
        isLoading = false
    }
    
   
    private func originalStaticView() -> some View {
        VStack {
            Spacer()
            Text(location.name).font(.largeTitle).foregroundStyle(.white)
            Spacer()
            Image(systemName: location.weather.icon)
                .resizable()
                .frame(width: 200, height: 200)
                .foregroundStyle(.yellow)
            Text(location.temperature.temperatureText)
                .font(.title)
                .foregroundStyle(.gray)
            Spacer()
            HStack {
                Text("A warm breeze drifted through tge streets as the afternoon sun hovered behind a veil of scattered clouds. In the north, the air felt dry abd dusty, while the southern coast carried the familiar scent of moisture from the sea. Somewhere in the distance, dark monsoon clouds gathered slowly, hinting at an evening shower that would cool the earth and fill the air with the sound of rain tapping on the rooftops.")
                    .font(.title3)
                    .foregroundStyle(.white)
                    .padding()
            }
            Spacer()
        }
    }
    
  
    private func realTimeWeatherView(weather: WeatherResponse) -> some View {
        VStack {
    
            Text(location.name).font(.largeTitle).foregroundStyle(.white).bold()
                .padding(.top, 20)
            
            Image(systemName: weatherCodeToIcon(weather.current.weatherCode))
                .resizable()
                .frame(width: 200, height: 200)
                .foregroundStyle(.yellow)
                .padding(20)
            
           
            Text("\(Int(weather.current.temperature2M)) °C")
                .font(.largeTitle)
                .foregroundStyle(.white)
                .bold()
            
            Text("Real-time weather")
                .font(.title2)
                .foregroundStyle(.gray)
            
            Spacer()
        }
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
        location: Location(name: "Mumbai", weather: .sunny, temperature: Temperature(min: 20, max: 25), latitude: 18.9582, longitude: 72.8358),
        weatherService: WeatherService(networkService: HttpNetworking())
    )
}
