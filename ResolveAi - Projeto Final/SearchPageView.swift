//
//  SearchPageView.swift
//  ResolveAi
//
//  Created by Turma21-02 on 24/07/25.
//

import SwiftUI

struct SearchPageView: View {
    
    @StateObject var viewModel = SearchViewModel()
    @State private var showingError = false
    
    var body: some View {
        NavigationView {
            ZStack {
                Color("AccentColor").ignoresSafeArea()
                
                
                VStack(spacing: 0) {
                    
                    
                    filtersSection
                    
                    
                    resultsSection
                }
                .alert(isPresented: $showingError) {
                    Alert(title: Text("Erro"), message: Text(viewModel.errorMessage ?? "Ocorreu um erro."), dismissButton: .default(Text("OK")))
                }
                .onReceive(viewModel.$errorMessage) { msg in
                    showingError = (msg != nil)
                }
            }
        }
    }
    
    private var filtersSection: some View {
        VStack(spacing: 12) {
            HStack(spacing: 8) {
                Picker("Estado", selection: $viewModel.selectedState) {
                    Text("Estado").tag(nil as States?)
                    ForEach(viewModel.states, id: \.id) {
                        Text($0.nome).tag($0 as States?)
                    }
                }
                .modifier(FilterPillStyle())
                
                Picker("Cidade", selection: $viewModel.selectedCity) {
                    Text("Cidade").tag(nil as Cities?)
                    ForEach(viewModel.cities, id: \.id) {
                        Text($0.nome).tag($0 as Cities?)
                    }
                }
                .modifier(FilterPillStyle())
                .disabled(viewModel.selectedState == nil)
            }
            
            HStack(spacing: 8) {
                Picker("Categoria", selection: $viewModel.selectedCategory) {
                    ForEach(viewModel.categories, id: \.self) {
                        Text($0).tag($0)
                    }
                }
                .modifier(FilterPillStyle())
                
                Picker("Faixa de Preço", selection: $viewModel.selectedPriceRange) {
                    ForEach(SearchViewModel.PriceRange.allCases) {
                        Text($0.rawValue).tag($0)
                    }
                }
                .modifier(FilterPillStyle())
            }
        }
        .padding()
    }
    
    private var resultsSection: some View {
            VStack {
                if viewModel.isLoading {
                    Spacer()
                    ProgressView()
                    Spacer()
                } else if viewModel.filteredUsers.isEmpty {
                    Spacer()
                    Text("Nenhum prestador encontrado.")
                        .foregroundColor(.gray)
                        .padding(.top, 50)
                    Spacer()
                } else {
                    
                        ScrollView {
                            VStack(spacing: 16) {
                                ForEach(viewModel.filteredUsers) { user in
                                    UserCardView(user: user)
                
                                }
                            }
                            .padding()
                        }
                }
            }
            .frame(maxWidth: .infinity, maxHeight: .infinity)
            .background(Color.white)
            .clipShape(RoundedCorner(radius: 48, corners: [.topLeft, .topRight]))
            .ignoresSafeArea(edges: .bottom)
        }
}

struct FilterPillStyle: ViewModifier {
    func body(content: Content) -> some View {
        content
            .pickerStyle(.menu)
            .frame(maxWidth: .infinity)
            .padding(.vertical, 8)
            .padding(.horizontal, 12)
            .background(Color.white)
            .cornerRadius(20)
            .shadow(color: Color.black.opacity(0.05), radius: 4, x: 0, y: 2)
            .tint(.primary)
    }
}

struct UserCardView: View {
    let user: User
    
    var body: some View {
        NavigationLink(destination: SinglePrestador(receivedUser: user)) {
            HStack(spacing: 12) {
                AsyncImage(url: URL(string: user.photo ?? "")) { phase in
                    if let image = phase.image {
                        image
                            .resizable()
                            .aspectRatio(contentMode: .fill)
                    } else {
                        Image(systemName: "person.circle.fill")
                            .resizable()
                            .foregroundColor(.gray.opacity(0.5))
                    }
                }
                .frame(width: 60, height: 60)
                .clipShape(Circle())
                
                VStack(alignment: .leading, spacing: 4) {
                    Text(user.name)
                        .font(.headline)
                    Text(user.occupation ?? "Profissional")
                        .font(.subheadline)
                        .foregroundColor(.secondary)
                    Text("\(user.city), \(user.state)")
                        .font(.caption)
                        .foregroundColor(.gray)
                }
                
                Spacer()
            }
            .padding()
            .background(Color(.systemGray6))
            .cornerRadius(20)
        }
    }
}

struct RoundedCorner: Shape {
    var radius: CGFloat = .infinity
    var corners: UIRectCorner = .allCorners

    func path(in rect: CGRect) -> Path {
        let path = UIBezierPath(roundedRect: rect, byRoundingCorners: corners, cornerRadii: CGSize(width: radius, height: radius))
        return Path(path.cgPath)
    }
}


#Preview {
    SearchPageView()
}
