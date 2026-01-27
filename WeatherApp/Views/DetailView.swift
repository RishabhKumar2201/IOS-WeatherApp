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
                    realTimeWeatherView(weather: weather, location: location)
                } else {
                    originalStaticView(location: location)
                }
            }
            .toolbar {
                ToolbarItem(placement: .principal) {
                    Text(location.name)
                        .foregroundStyle(.white)
                        .font(.title2)
                        .fontWeight(.semibold)
                }
            }
//            .navigationBarBackButtonHidden(true)
            .toolbarBackground(Color("backgroundColor"), for: .navigationBar)
            .toolbarColorScheme(.dark, for: .navigationBar)
            .task {
                await fetchWeather()
            }
        }
    }
    
    func fetchWeather() async {
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
}
