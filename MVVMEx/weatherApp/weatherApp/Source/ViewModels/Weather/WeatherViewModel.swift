//
//  WeatherViewModel.swift
//  weatherApp
//
//  Created by 이지석 on 2022/01/07.
//

import Alamofire

class WeatherViewModel {
    func showWeahter(completion: @escaping (WeatherEntity) -> ()) {
        URLSession.shared.dataTask(with: URL(string: Constant.BASE_URL + "?q=Osan&appid=\(Constant.APP_KEY)&units=metric")!) { response, _, _ in
            guard let response = response else { return }
            guard let model = try? JSONDecoder().decode(WeatherEntity.self, from: response) else { return }
            completion(model)
        }.resume()
    }
}
