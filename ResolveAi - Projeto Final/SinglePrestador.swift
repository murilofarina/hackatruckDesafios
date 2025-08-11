import SwiftUI

struct SinglePrestador: View {
    
    @StateObject private var viewModel = ProviderViewModel()
    @State private var mostrarPopup = false
    var receivedUser: User
    
    var body: some View {
        NavigationView {
            ZStack {
                Color.white.ignoresSafeArea()
                
                //            if viewModel.isLoading {
                //                ProgressView("Carregando Perfil...")
                //            } else if let errorMessage = viewModel.errorMessage {
                //                Text("Erro: \(errorMessage)")
                //                    .padding()
                //            } else if let user = viewModel.userProfile {
                VStack(spacing: 16) {
                    
                    AsyncImage(url: URL(string: receivedUser.photo ?? "")) { image in
                        image
                            .resizable()
                            .scaledToFill()
                    } placeholder: {
                        ProgressView()
                    }
                    .frame(width: 150, height: 150)
                    .clipShape(Circle())
                    
                    Text(receivedUser.name)
                        .font(.title)
                        .bold()
                    
                    HStack {
                        Image(systemName: "mappin.circle")
                        Text("\(receivedUser.city), \(receivedUser.state)")
                            .foregroundColor(.gray)
                    }
                    
                    HStack {
                        VStack {
                            Image(systemName: "briefcase")
                            Text(receivedUser.occupation ?? "Não informado")
                        }
                        .frame(width: 120, height: 100)
                        .padding()
                        .background(Color(.systemGray6))
                        .cornerRadius(12)
                        
                        VStack {
                            Image(systemName: "dollarsign.circle")
                            Text(receivedUser.hourValueFormatted)
                                .font(.caption)
                                .bold()
                        }
                        .frame(width: 120, height: 100)
                        .padding()
                        .background(Color(.systemGray6))
                        .cornerRadius(12)
                    }
                    
                    Text(receivedUser.bio ?? "Sem biografia disponível.")
                        .frame(maxWidth: .infinity, alignment: .leading)
                        .padding()
                        .background(Color(.systemGray6))
                        .cornerRadius(12)
                    
                    Button("Contratar") {
                        mostrarPopup = true
                    }
                    .padding()
                    .frame(maxWidth: .infinity, alignment: .center)
                    .foregroundStyle(.white)
                    .background(Color.blue)
                    .cornerRadius(55)
                    .padding(.top, 15)
                    
                    Spacer()
                }
                .padding(30)
                
                if mostrarPopup {
                    Color.black.opacity(0.4)
                        .ignoresSafeArea()
                        .onTapGesture {
                            mostrarPopup = false
                        }
                    
                    ContratoView(user: receivedUser)
                        .background(Color.white)
                        .cornerRadius(25)
                        .padding(30)
                        .shadow(radius: 10)
                        .frame(width: .infinity)
                }
            }
            //        }
            .onAppear {
                Task {
                    await viewModel.fetchData()
                }
            }
        }
    }
}
#Preview {
    SinglePrestador(receivedUser: User(
        id: "preview123",
        name: "Nome de Exemplo",
        isWorker: true,
        state: "SP",
        city: "São Paulo",
        occupation: "Desenvolvedor(a) de Exemplo",
        category: "Testes",
        bio: "Esta é uma biografia de exemplo para o preview do Xcode.",
        photo: " ",
        latitude: -23.55,
        longitude: -46.63,
        hourValue: 100.0
    ))

}
