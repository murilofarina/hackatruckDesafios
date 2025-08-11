//
//  CityModel.swift
//  projeto
//
//  Created by Turma02-26 on 23/07/25.
//

import Foundation
import Combine

class CityModel: ObservableObject {
    @Published var cities: [Cities] = []

    func fetch(id: Int) {
        
        guard let url = URL(string: "https://servicodados.ibge.gov.br/api/v1/localidades/estados/\(id)/municipios") else {
            return
        }
        
        let task = URLSession.shared.dataTask(with: url) { [weak self] data, _, error in
            guard let data = data, error == nil else { return }

            do {
                let parsed = try JSONDecoder().decode([Cities].self, from: data)

                DispatchQueue.main.async {
                    self?.cities = parsed
                }

            }
            catch {
                print(error)
            }

        }
        task.resume()
    }
}
