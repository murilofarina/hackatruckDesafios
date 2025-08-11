//
//  RegistrationViewModel.swift
//  ResolveAi
//
//  Created by Turma02-10 on 29/07/25.
//

import Foundation

@MainActor
class RegistrationViewModel: ObservableObject {
    
  
    @Published var name: String = ""
    @Published var photoURL: String = ""
    @Published var bio: String = ""
    @Published var hourValue: String = ""
    @Published var currentState: States? = nil
    @Published var selectedCity: Cities? = nil
    @Published var currentOccupation: String = ""
    
    @Published var createdUser: User? = nil
  
    @Published var states: [States] = []
    @Published var cities: [Cities] = []
    let occupations: [String] = ["Encanador", "Diarista", "Eletricista", "Pintor", "Pequenos Reparos"]
    

    @Published var isLoading = false
    @Published var errorMessage: String?
    @Published var registrationSuccessful = false
    
    init() {
        Task {
            await fetchStates()
        }
    }
    
  
    
    func fetchStates() async {
        do {
            self.states = try await NetworkService.shared.fetchStates()
        } catch {
            self.errorMessage = "Falha ao buscar estados."
        }
    }
    
    func fetchCities() async {
        guard let currentState = currentState else { return }
        cities = []
        selectedCity = nil
        do {
            self.cities = try await NetworkService.shared.fetchCities(forStateID: currentState.id)
        } catch {
            self.errorMessage = "Falha ao buscar cidades."
        }
    }
    
    func registerUser() async {
        isLoading = true
        errorMessage = nil
        defer { isLoading = false }
        
        guard !name.isEmpty, let state = currentState, let city = selectedCity, !currentOccupation.isEmpty else {
            errorMessage = "Por favor, preencha todos os campos obrigatórios."
            return
        }
        
        let newUserPayload = NewUserPayload(
            name: name,
            isWorker: true,
            occupation: currentOccupation,
            hourValue: Double(hourValue),
            bio: bio,
            photo: photoURL,
            state: state.sigla,
            city: city.nome,
            category: "Casa" // Exemplo
        )
        
        do {
            let createdUser = try await NetworkService.shared.createUser(payload: newUserPayload)
            self.createdUser = createdUser
            AuthManager.shared.login(user: createdUser)
            registrationSuccessful = true
        } catch {
            errorMessage = "Erro ao registrar: \(error.localizedDescription)"
        }
    }
}
