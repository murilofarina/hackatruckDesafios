//
//  StateModel.swift
//  projeto
//
//  Created by Turma02-26 on 23/07/25.
//

import Foundation
import Combine

class StateModel: ObservableObject {
    @Published var states: [States] = []

    func fetch() {
        
        guard let url = URL(string: "https://servicodados.ibge.gov.br/api/v1/localidades/estados?orderBy=nome") else {
            return
        }
        
        let task = URLSession.shared.dataTask(with: url) { [weak self] data, _, error in
            guard let data = data, error == nil else { return }

            do {
                let parsed = try JSONDecoder().decode([States].self, from: data)

                DispatchQueue.main.async {
                    self?.states = parsed
                }

            }
            catch {
                print(error)
            }

        }
        task.resume()
    }
}
