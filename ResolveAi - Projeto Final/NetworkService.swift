//
//  NetworkService.swift
//  Project
//
//  Created by Turma02-10 on 28/07/25.
//

import Foundation

class NetworkService {
    static let shared = NetworkService()
    private init() {}
    
    private let baseURL = "http://192.168.128.45:1880"
    
    // MARK: - User Functions
    
    func fetchAllUsers() async throws -> [User] {
        let urlString = "\(baseURL)/getProject" // ou /users se você já criou o endpoint
        guard let url = URL(string: urlString) else {
            throw URLError(.badURL)
        }
        
        let (data, response) = try await URLSession.shared.data(from: url)
        
        guard let httpResponse = response as? HTTPURLResponse, (200...299).contains(httpResponse.statusCode) else {
            throw URLError(.badServerResponse)
        }
        
        return try JSONDecoder().decode([User].self, from: data)
    }
    
    func fetchUser(withId userId: String) async throws -> User {
        let urlString = "\(baseURL)/users/\(userId)"
        guard let url = URL(string: urlString) else {
            throw URLError(.badURL)
        }
        
        let (data, response) = try await URLSession.shared.data(from: url)
        
        guard let httpResponse = response as? HTTPURLResponse, (200...299).contains(httpResponse.statusCode) else {
            throw URLError(.badServerResponse)
        }
        
        return try JSONDecoder().decode(User.self, from: data)
    }
    
    func createUser(payload: NewUserPayload) async throws -> User {
        let urlString = "\(baseURL)/users" // O endpoint de POST para criar usuários
        guard let url = URL(string: urlString) else { throw URLError(.badURL) }
     
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        request.httpBody = try JSONEncoder().encode(payload)
     
        let (data, response) = try await URLSession.shared.data(for: request)
     
        guard let httpResponse = response as? HTTPURLResponse, (200...299).contains(httpResponse.statusCode) else {
            // Se a resposta for um erro, tenta decodificar uma mensagem de erro do servidor
            if let apiError = try? JSONDecoder().decode([String: String].self, from: data), let message = apiError["error"] {
                throw NSError(domain: "", code: 0, userInfo: [NSLocalizedDescriptionKey: message])
            }
            throw URLError(.badServerResponse)
        }
     
        // Decodifica e retorna o usuário completo que a API devolveu
        return try JSONDecoder().decode(User.self, from: data)
    }
    
    // MARK: - Contract Functions
    
    func fetchContracts(forUserId userId: String) async throws -> [Contract] {
        let urlString = "\(baseURL)/users/\(userId)/contracts"
        guard let url = URL(string: urlString) else {
            throw URLError(.badURL)
        }
        
        let (data, response) = try await URLSession.shared.data(from: url)
        
        guard let httpResponse = response as? HTTPURLResponse, (200...299).contains(httpResponse.statusCode) else {
            throw URLError(.badServerResponse)
        }
        
        return try JSONDecoder().decode([Contract].self, from: data)
    }
    
    func createContract(clientId: String, providerId: String) async throws {
        let urlString = "\(baseURL)/contracts"
        guard let url = URL(string: urlString) else {
            throw URLError(.badURL)
        }
        
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        
        let requestBody = ["clientId": clientId, "providerId": providerId]
        request.httpBody = try JSONEncoder().encode(requestBody)
        
        let (_, response) = try await URLSession.shared.data(for: request)
        
        guard let httpResponse = response as? HTTPURLResponse, (200...299).contains(httpResponse.statusCode) else {
            throw URLError(.badServerResponse)
        }
    }
    
    // MARK: - IBGE Functions
    
    func fetchStates() async throws -> [States] {
        guard let url = URL(string: "https://servicodados.ibge.gov.br/api/v1/localidades/estados?orderBy=nome") else {
            throw URLError(.badURL)
        }
        let (data, response) = try await URLSession.shared.data(from: url)
        guard let httpResponse = response as? HTTPURLResponse, (200...299).contains(httpResponse.statusCode) else {
            throw URLError(.badServerResponse)
        }
        return try JSONDecoder().decode([States].self, from: data)
    }

    func fetchCities(forStateID stateID: Int) async throws -> [Cities] {
        let urlString = "https://servicodados.ibge.gov.br/api/v1/localidades/estados/\(stateID)/municipios?orderBy=nome"
        guard let url = URL(string: urlString) else {
            throw URLError(.badURL)
        }
        let (data, response) = try await URLSession.shared.data(from: url)
        guard let httpResponse = response as? HTTPURLResponse, (200...299).contains(httpResponse.statusCode) else {
            throw URLError(.badServerResponse)
        }
        return try JSONDecoder().decode([Cities].self, from: data)
    }
}
