import Foundation
import PlaygroundSupport

struct CurrentWeather: Codable {
    let temperature: Double
    let windspeed: Double
}

struct WeatherResponse: Codable {
    let latitude: Double
    let longitude: Double
    let current_weather: CurrentWeather
}

func fetchWeather(latitude: Double, longitude: Double, cityName: String) async {
    guard let url = URL(string: "https://api.open-meteo.com/v1/forecast?latitude=-33.87&longitude=151.21&current_weather=true") else {
        print("Bad URL")
        return
    }
    
    do {
        let (data, _) = try await URLSession.shared.data(from: url)
        
        let decoded = try JSONDecoder().decode(WeatherResponse.self, from: data)
        print("\(cityName): \(decoded.current_weather.temperature)°C, wind \(decoded.current_weather.windspeed) km/h")
    } catch {
        print("Error fetching JSON: \(error)")
    }
}

func fetchWeathers() async {
    await fetchWeather(latitude: 43.65, longitude: -79.38, cityName: "Toronto")
    await fetchWeather(latitude: -33.87, longitude: 151.21, cityName: "Sydney")
}

Task {
    await fetchWeathers()
}
