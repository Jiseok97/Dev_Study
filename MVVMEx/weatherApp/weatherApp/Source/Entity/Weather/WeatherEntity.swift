//
//  WeatherEntity.swift
//  weatherApp
//
//  Created by 이지석 on 2022/01/22.
//

struct WeatherEntity: Decodable {
    let coord: locationInfo
    let weather : weatherInfo
    let main : tempInfo
    let name: String
    let cod: Int
}

struct locationInfo : Decodable {
    let lon: Double
    let lat: Double
}

struct weatherInfo : Decodable {
    let id: Int
    let main: String
    let description: String
    let icon : String
}

struct tempInfo : Decodable {
    let temp : Double
    let feels_like: Double
    let temp_min: Double
    let temp_max: Double
    let pressure: Int
    let humidity: Int
}
