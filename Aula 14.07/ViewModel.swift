//
//  ViewModel.swift
//  Aula 14.07
//
//  Created by Turma21-02 on 14/07/25.
//

import Foundation

struct Got: Codable, Identifiable {
    let id: Int
    let firstName: String?
    let lastName: String?
    let fullName: String?
    let title: String?
    let family: String?
    let image: String?
    let imageUrl: String?
}

class ViewModel: ObservableObject {
    
    @Published var personagens: [Got] = []
    
    func fetch() {
        
        guard let url = URL(string: "https://thronesapi.com/api/v2/Characters") else {
            return
        }
        
        let task = URLSession.shared.dataTask(with: url){ [weak self] data, _, error in
            
            guard let data = data, error == nil else {
                return
            }
            
            do {
                
                let parsed = try JSONDecoder().decode([Got].self, from: data)
                
                DispatchQueue.main.async {
                    
                    self?.personagens = parsed
                }
            }
            
            catch {
                print(error)
            }
        }
        
        task.resume()
    }
}
