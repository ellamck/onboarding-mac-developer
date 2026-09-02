import Foundation

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

func fetchWeather() async {
    guard let url = URL(string: "https://api.open-meteo.com/v1/forecast?latitude=-33.87&longitude=151.21&current_weather=true") else {
        print("Bad URL")
        return
    }
    
    do {
        let (data, _) = try await URLSession.shared.data(from: url)
        
        let decoded = try JSONDecoder().decode(WeatherResponse.self, from: data)
                print("Latitude: \(decoded.latitude)")
                print("Longitude: \(decoded.longitude)")
                print("Temperature: \(decoded.current_weather.temperature)°C")
                print("Wind speed: \(decoded.current_weather.windspeed) km/h")
    } catch {
        print("Error fetching JSON: \(error)")
    }
}

await fetchWeather()
