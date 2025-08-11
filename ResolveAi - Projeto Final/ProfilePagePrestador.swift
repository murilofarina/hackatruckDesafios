import SwiftUI

struct ProfilePagePrestador: View {
    var body: some View {
        VStack(spacing: 20) {
            // MARK: - Perfil
            VStack(spacing: 8) {
                Image("ic-fotoGrande")
                    .resizable()
                    .frame(width: 100, height: 100)
                    .foregroundColor(Color.blue)

                Text("Nome do Prestador")
                    .font(.title3)
                    .fontWeight(.semibold)

                HStack(spacing: 5) {
                    Image(systemName: "location")
                    Text("Localização")
                }
                .font(.subheadline)
                .foregroundColor(.gray)

                Text("Biografia do Prestador...")
                    .font(.footnote)
                    .multilineTextAlignment(.center)
                    .padding(.horizontal)
            }
            .padding(.top)

            // MARK: - Botões de Compartilhar e Editar
            HStack(spacing: 20) {
                Button("Compartilhar") {}
                    .foregroundColor(Color("Cinza"))
                    .frame(maxWidth: .infinity)
                    .padding()
                    .background(Color("BrancoAux"))
                    .cornerRadius(40)

                Button("Editar Perfil") {}
                    .foregroundColor(Color("Cinza"))
                    .frame(maxWidth: .infinity)
                    .padding()
                    .background(Color("BrancoAux"))
                    .cornerRadius(40)
            }
            .padding(.horizontal)

            // MARK: - Minhas Contratações
            HStack {
                Text("Meus Serviços")
                    .font(.title3)
                    .fontWeight(.semibold)

                Spacer()

                Button("Ver mais") {}
                    .font(.footnote)
                    .foregroundColor(.gray)
            }
            .padding(.horizontal)

            // MARK: - Lista de Contratações com ForEach direto
            ScrollView {
                VStack(spacing: 15) {
                    ForEach(0..<3) { i in
                        HStack(spacing: 15) {
                            Image(systemName: "person")
                                .resizable()
                                .frame(width: 40, height: 40)
                                .foregroundColor(.white)

                            VStack(alignment: .leading, spacing: 4) {
                                Text("Nome do Usuário")
                                    .foregroundColor(.white)
                                    .fontWeight(.semibold)

                                Text("Tipo de Serviço")
                                    .foregroundColor(.white.opacity(0.9))
                                    .font(.subheadline)

                                Text("Localização")
                                    .foregroundColor(.white.opacity(0.9))
                                    .font(.subheadline)
                            }

                            Spacer()
                        }
                        .padding()
                        .background(Color("AccentColor").opacity(1.0 - Double(i) * 0.1))
                        .cornerRadius(16)
                    }
                }
                .padding(.horizontal)
            }

            Spacer()
        }
    }
}

#Preview {
    ProfilePagePrestador()
}
