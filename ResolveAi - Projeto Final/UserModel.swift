//
//  UserModel.swift
//  projeto
//
//  Created by Turma02-26 on 24/07/25.
//

import Foundation

class UserModel: ObservableObject {
    func createUser(user: User, completion: @escaping (Bool) -> Void) {
        guard let url = URL(string: "http://192.168.128.45:1880/postProject") else {
            completion(false)
            return
        }
        
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        
        do {
            let jsonData = try JSONEncoder().encode(user)
            request.httpBody = jsonData
        } catch {
            print("Erro ao codificar usuário: \(error)")
            completion(false)
            return
        }
        
        let task = URLSession.shared.dataTask(with: request, completionHandler: handleResponse(completion: completion))
        task.resume()
    }
    
    private func handleResponse(data: Data?, response: URLResponse?, error: Error?, completion: @escaping (Bool) -> Void) {
        if let error = error {
            print("Erro na requisição: \(error)")
            completion(false)
            return
        }
        
        if let httpResponse = response as? HTTPURLResponse, (200...299).contains(httpResponse.statusCode) {
            DispatchQueue.main.async {
                completion(true)
            }
        } else {
            print("Resposta inválida do servidor.")
            completion(false)
        }
    }
    
    // Adaptador para usar a handleResponse como completionHandler do dataTask
    private func handleResponse(completion: @escaping (Bool) -> Void) -> (Data?, URLResponse?, Error?) -> Void {
        return { data, response, error in
            self.handleResponse(data: data, response: response, error: error, completion: completion)
        }
    }
}
