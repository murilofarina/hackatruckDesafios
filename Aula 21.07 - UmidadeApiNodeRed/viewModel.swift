//
//  viewModel.swift
//  Aula 21.07 - umidadeApinNodeRed
//
//  Created by Turma21-02 on 21/07/25.
//

import Foundation

struct Umidade: Decodable, Hashable {
    let umidade: String?
}

class ViewModel: ObservableObject {
    
    @Published var arrayUmidade: [Umidade] = []
    
    func fetch() {
        
        guard let url = URL(string: "http://192.168.128.96:1880/leituraMurilo") else {
            return
        }
        
        let task = URLSession.shared.dataTask(with: url){ [weak self] data, _, error in
            
            guard let data = data, error == nil else {
                return
            }
            
            do {
                
                let parsed = try JSONDecoder().decode([Umidade].self, from: data)
                
                DispatchQueue.main.async {
                    
                    self?.arrayUmidade = parsed
                }
            }
            
            catch {
                print(error)
            }
        }
        
        task.resume()
    }
}
