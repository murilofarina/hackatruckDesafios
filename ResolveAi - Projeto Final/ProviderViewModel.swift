//
//  ProviderViewModel.swift
//  Project
//
//  Created by Turma02-10 on 28/07/25.
//

import Foundation
import SwiftUI

@MainActor
class ProviderViewModel: ObservableObject {
    
    @Published var userProfile: User?
    
    @Published var contracts: [Contract] = []
    
    @Published var isLoading: Bool = false
    
    @Published var errorMessage: String?
    
    
    init() {
        Task {
            await fetchData()
        }
    }
    
    
    func fetchData() async {
        isLoading = true
        errorMessage = nil
        
        let providerId = "0ba738be0fb5f4e067b2dd5ec1ba5ea4"
        
 
        defer {
            isLoading = false
        }
        
        do {
           
            async let userProfileRequest = NetworkService.shared.fetchUser(withId: providerId)
            async let contractsRequest = NetworkService.shared.fetchContracts(forUserId: providerId)
           
            self.userProfile = try await userProfileRequest
            self.contracts = try await contractsRequest
            
        } catch {
            self.errorMessage = "Falha ao buscar dados do prestador: \(error.localizedDescription)"
        }
    }
}
