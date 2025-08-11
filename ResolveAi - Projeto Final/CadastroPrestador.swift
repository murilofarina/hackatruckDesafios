//
//  ContentView.swift
//  projeto
//
//  Created by Turma02-26 on 23/07/25.
//

import SwiftUI

struct CadastroPrestador: View {
    
    // Suas propriedades @State e @StateObject continuam as mesmas
    @StateObject var stateModel = StateModel()
    @StateObject var cityModel = CityModel()
    @StateObject var userModel = UserModel()
    
    @State var occupations: [String] = ["Casa", "Encanamentos", "Elétrica", "Pequenos Reparos"]
    
    @State var currentOccupation: String = ""
    @State var currentState: States? = nil
    @State var selectedCity: Cities? = nil
    @State var searchText: String = ""
    @State var photoURL: String = ""
    @State var bio: String = ""
    @State var hourValue: String = ""
    @State var name: String = ""
    @State var message: String = ""
    
    @State var createdUser: User? = nil
    @State var navigateToSuccess = false
    
    @Binding var flow: AppFlow
    
    @State private var selectedTab = 0
    
    // O corpo principal da View agora é muito mais limpo.
    // Ele apenas chama as sub-views que criamos abaixo.
    var body: some View {
        NavigationStack {
            ScrollView(.vertical) {
                VStack(alignment: .leading) {
                    
                    Text("Criar perfil de Prestador")
                        .font(.title2)
                        .frame(maxWidth: .infinity, alignment: .center)
                        .padding()
                    
                    personalInfoSection
                    
                    locationSection
                    
                    bioSection
                    
                    serviceSection
                    
                    createButtonSection
                    
                    Text(message)
                        .foregroundColor(message.contains("sucesso") ? .green : .red)
                    
                    // O NavigationLink para a tela de sucesso
                    NavigationLink(
                        destination: createdUser.map {_ in
                            TabViewPrestador(flow: $flow) },
                        isActive: $navigateToSuccess
                    ) {
                        EmptyView()
                    }
                }
                .padding()
            }
            .onAppear() {
                stateModel.fetch()
            }
            .onChange(of: stateModel.states) { _, newStates in
                if let firstState = newStates.first {
                    // Lógica para carregar cidades
                    cityModel.fetch(id: firstState.id)
                }
            }
        }
    }
    
    
    // Seção para Nome e Foto
    private var personalInfoSection: some View {
        VStack(alignment: .leading) {
            Text("Nome Completo")
                .padding(.top, 8)
            TextField("Digite seu nome completo", text: $name)
                .frame(height: 10)
                .padding()
                .background(Color(.systemGray6))
                .cornerRadius(55)
            
            Text("Sua foto")
                .padding(.top, 8)
            TextField("Digite a url da imagem", text: $photoURL)
                .frame(height: 10)
                .padding()
                .background(Color(.systemGray6))
                .cornerRadius(55)
        }
    }
    
    // Seção para Estado e Cidade
    private var locationSection: some View {
        VStack(alignment: .leading) {
            Text("Sua localização")
                .padding(.top, 8)
            
            Picker("Estado", selection: $currentState) {
                Text("Estado").tag(nil as States?)
                ForEach(stateModel.states, id: \.self) { state in
                    Text(state.nome).tag(Optional(state))
                }
            }
            .onChange(of: currentState) { _, selectedState in
                if let state = selectedState {
                    cityModel.fetch(id: state.id)
                }
            }
            .frame(maxWidth: .infinity, minHeight: 40, alignment: .leading)
            .accentColor(.gray)
            .background(Color(.systemGray6))
            .cornerRadius(55)
            
            // Lógica de busca de cidade (pode ser extraída também se ficar complexa)
            TextField("Digite a cidade", text: $searchText)
                .frame(height: 10)
                .padding()
                .background(Color(.systemGray6))
                .cornerRadius(55)
            
            if !searchText.isEmpty {
                ForEach(cityModel.cities.filter {
                    $0.nome.lowercased().contains(searchText.lowercased())
                }, id: \.id) { city in
                    Button(action: {
                        selectedCity = city
                        searchText = city.nome
                    }) {
                        HStack {
                            Text(city.nome)
                            Spacer()
                        }
                        .padding(.vertical, 4)
                    }
                    .buttonStyle(PlainButtonStyle())
                }
            }
        }
    }
    
    // Seção para a Biografia
    private var bioSection: some View {
        VStack(alignment: .leading) {
            Text("Biografia")
                .padding(.top, 8)
            ZStack(alignment: .topLeading) {
                TextEditor(text: $bio)
                    .scrollContentBackground(.hidden)
                    .background(Color(.systemGray6))
                    .frame(height: 120)
                    .cornerRadius(8)
                
                if bio.isEmpty {
                    Text("Digite sua biografia")
                        .foregroundStyle(.tertiary)
                        .padding(.top, 8)
                        .padding(.leading, 5)
                        .allowsHitTesting(false)
                }
            }
        }
    }
    
    // Seção para Ocupação e Valor/Hora
    private var serviceSection: some View {
        VStack(alignment: .leading) {
            Text("Serviço")
                .padding(.top, 8)
            
            Picker("Tipo de serviços", selection: $currentOccupation) {
                Text("Tipo de serviços").tag("")
                ForEach(occupations, id: \.self) { occupation in
                    Text(occupation)
                }
            }
            .frame(maxWidth: .infinity, minHeight: 40, alignment: .leading)
            .accentColor(.gray)
            .background(Color(.systemGray6))
            .cornerRadius(55)
            
            TextField("Digite o valor da sua hora", text: $hourValue)
                .keyboardType(.numberPad)
                .frame(height: 10)
                .padding()
                .background(Color(.systemGray6))
                .cornerRadius(55)
        }
    }
    
    // Seção para o Botão de Criar Usuário
    private var createButtonSection: some View {
        Button("Criar Usuário") {
            // A lógica de criação do usuário continua a mesma
            // Lembre-se que esta parte ainda precisa ser atualizada para
            // o nosso 'User' definitivo e para o 'NetworkService'.
            let newUser = User(
                id: UUID().uuidString, // ID Temporário
                name: name,
                isWorker: true,
                state: currentState?.sigla ?? "",
                city: selectedCity?.nome ?? "",
                occupation: currentOccupation, category: currentOccupation,
                bio: bio,
                photo: photoURL,
                latitude: 0.0, // Temporário
                longitude: 0.0, // Temporário
                hourValue: Double(hourValue)
            )
            
            userModel.createUser(user: newUser) { success in
                DispatchQueue.main.async {
                    if success {
                        createdUser = newUser
                        navigateToSuccess = true
                        flow = .tabviewprestador
                        
                    }
                    message = success ? "Usuário criado com sucesso!" : "Falha ao criar usuário."
                }
            }
        }
        .padding()
        .frame(maxWidth: .infinity, alignment: .center)
        .foregroundStyle(.white)
        .background(Color.blue)
        .cornerRadius(55)
        .padding(.top, 15)
    }
}


#Preview {
    CadastroPrestador(flow: .constant(.start))
}
