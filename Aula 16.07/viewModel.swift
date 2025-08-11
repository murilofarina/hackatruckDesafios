//
//  viewModel.swift
//  Aula 16.07
//
//  Created by Turma21-02 on 16/07/25.
//

import Foundation

struct Cel: Codable, Hashable {
    let nomeCelular: String?
    let linha: String?
    let marca: String?
    let celulares: [Celulares]
}

struct Celulares: Codable, Hashable {
    let linha: String?
    let modelo: String?
    let cor: String?
    let preco: Double?
    let foto: String?
}

class ViewModel: ObservableObject {
    
    @Published var cels: [Cel] = []
    
    func fetch() {
        
        guard let url = URL(string: "http://127.0.0.1:1880/leituraMurilo") else {
            return
        }
        
        let task = URLSession.shared.dataTask(with: url){ [weak self] data, _, error in
            
            guard let data = data, error == nil else {
                return
            }
            
            do {
                
                let parsed = try JSONDecoder().decode([Cel].self, from: data)
                
                DispatchQueue.main.async {
                    
                    self?.cels = parsed
                }
            }
            
            catch {
                print(error)
            }
        }
        
        task.resume()
    }
}
