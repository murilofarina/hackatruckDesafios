import Foundation
import Combine
import SwiftUI

@MainActor
class SearchViewModel: ObservableObject {

    // MARK: - Propriedades Publicadas (Controlam a UI)
    @Published var states: [States] = []
    @Published var cities: [Cities] = []
    @Published var filteredUsers: [User] = []
    @Published var isLoading: Bool = false
    @Published var errorMessage: String?
    
    // MARK: - Propriedades de Filtro
    @Published var selectedState: States? {
        didSet { Task { await fetchCitiesForSelectedState() } }
    }
    @Published var selectedCity: Cities? {
        didSet { applyFilters() }
    }
    @Published var selectedCategory: String = "Todas as Categorias" {
        didSet { applyFilters() }
    }
    @Published var selectedPriceRange: PriceRange = .all {
        didSet { applyFilters() }
    }
    
    // MARK: - Dados Internos
    private var allUsers: [User] = [] {
        didSet { applyFilters() }
    }
    private var citiesCache: [Int: [Cities]] = [:]

    // MARK: - Configurações
    enum PriceRange: String, CaseIterable, Identifiable {
        case all = "Qualquer Preço"
        case upTo50 = "Até R$50/h"
        case between50and100 = "R$50 - R$100/h"
        case over100 = "Acima de R$100/h"
        var id: String { self.rawValue }
    }

    let categories = ["Todas as Categorias", "Elétrica", "Encanamentos", "Casa", "Pequenos Reparos"]

    // MARK: - Inicializador
    init() {
        Task {
            await fetchInitialData()
        }
    }
    
    // MARK: - Lógica de Busca de Dados
    
    /// Busca todos os dados iniciais necessários para a tela.
    func fetchInitialData() async {
        isLoading = true
        defer { isLoading = false }
        
        async let statesTask: () = fetchStates()
        async let usersTask: () = fetchAllUsers()
        
        await statesTask
        await usersTask
    }

    /// Busca a lista de todos os usuários através do NetworkService.
    func fetchAllUsers() async {
        do {
            self.allUsers = try await NetworkService.shared.fetchAllUsers()
        } catch {
            self.errorMessage = "Falha ao buscar usuários: \(error.localizedDescription)"
        }
    }

    /// Busca a lista de estados do IBGE através do NetworkService.
    func fetchStates() async {
        do {
            self.states = try await NetworkService.shared.fetchStates()
        } catch {
            self.errorMessage = "Falha ao buscar estados: \(error.localizedDescription)"
        }
    }

    /// Busca as cidades para o estado selecionado, usando cache.
    private func fetchCitiesForSelectedState() async {
        cities = []
        selectedCity = nil
        guard let state = selectedState else { return }
        
        if let cachedCities = citiesCache[state.id] {
            self.cities = cachedCities
            return
        }
        
        do {
            let fetchedCities = try await NetworkService.shared.fetchCities(forStateID: state.id)
            self.citiesCache[state.id] = fetchedCities
            self.cities = fetchedCities
        } catch {
            self.errorMessage = "Falha ao buscar cidades: \(error.localizedDescription)"
        }
    }
    
    // MARK: - Lógica de Filtragem
    
    /// Aplica todos os filtros selecionados à lista de usuários.
    private func applyFilters() {
        var results = allUsers.filter { $0.isWorker }

        if let state = selectedState {
            results = results.filter { $0.state.caseInsensitiveCompare(state.sigla) == .orderedSame }
        }

        if let city = selectedCity {
            results = results.filter { $0.city.caseInsensitiveCompare(city.nome) == .orderedSame }
        }

        if selectedCategory != "Todas as Categorias" {
            results = results.filter { ($0.category ?? "").caseInsensitiveCompare(selectedCategory) == .orderedSame }
        }

        switch selectedPriceRange {
        case .upTo50:
            results = results.filter { ($0.hourValue ?? 0) <= 50 }
        case .between50and100:
            results = results.filter { ($0.hourValue ?? 0) > 50 && ($0.hourValue ?? 0) <= 100 }
        case .over100:
            results = results.filter { ($0.hourValue ?? 0) > 100 }
        case .all:
            break
        }

        self.filteredUsers = results
    }
}
