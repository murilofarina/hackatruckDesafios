import SwiftUI

struct SheetMapa: View {
    
    @Binding var usuario: User

    var body: some View {
        ZStack {
            Color.white.ignoresSafeArea()
            VStack(spacing: 16) {
                AsyncImage(url: URL(string: usuario.photo ?? "")) { image in
                    image
                        .resizable()
                        .scaledToFill()
                } placeholder: {
                    ProgressView()
                }
                .frame(width: 150, height: 150)
                .clipShape(Circle())

                Text(usuario.name ?? "Nome do Prestador")
                    .font(.title)
                    .bold()

                Text("\(usuario.city ?? ""), \(usuario.state ?? "")")
                    .foregroundColor(.gray)

                HStack {
                    VStack {
                        Image(systemName: "briefcase")
                        Text(usuario.occupation ?? "Tipo de Serviço")
                    }
                    .frame(width: 120, height: 100)
                    .padding()
                    .background(Color(.systemGray6))
                    .cornerRadius(12)

                    VStack {
                        Image(systemName: "dollarsign.circle")
                        Text("\(usuario.hourValueFormatted ?? "0,00") por hora")
                    }
                    .frame(width: 120, height: 100)
                    .padding()
                    .background(Color(.systemGray6))
                    .cornerRadius(12)
                }

                Text(usuario.bio ?? "Sem biografia disponível.")
                    .frame(maxWidth: .infinity)
                    .padding()
                    .background(Color(.systemGray6))
                    .cornerRadius(12)

                Spacer()
            }
            .padding(30)
            .padding(.top, 32)
        }
    }
}
