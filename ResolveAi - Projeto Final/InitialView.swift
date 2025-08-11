

import SwiftUI

struct InitialView: View {
    
    @Binding var flow: AppFlow

    var body: some View {
        
        ZStack {
            Color("AzulEscuro")
                .ignoresSafeArea()
            
            VStack(spacing: 20) {
                Spacer()
                
                Image("ic-logoBranca")
                    .padding(.bottom)
                
                Image("ic-vetoresInicial")
                    .resizable()
                     .scaledToFill() // ou .aspectRatio(contentMode: .fill)
                     .ignoresSafeArea(.container, edges: .horizontal)

                Text("Conectamos quem precisa com quem resolve.")
                    .foregroundStyle(.white)
                    .font(.subheadline)
                    .multilineTextAlignment(.center)
                Text("Simples. Rápido. Perto de você.")
                    .foregroundStyle(.white)
                    .bold()
                    .padding(.bottom)

                Button(action: {
                    flow = .contratante
                }) {
                    Text("Entrar como Contratante")
                        .foregroundColor(Color("AzulEscuro"))
                        .padding()
                        .frame(maxWidth: .infinity)
                        .background(Color.white)
                        .cornerRadius(30)
                }
                .padding(.horizontal)
                

                Button(action: {
                    flow = .prestador
                    
                        ()
                }) {
                    Text("Entrar como Prestador de Serviço")
                        .foregroundColor(Color("AzulEscuro"))
                        .padding()
                        .frame(maxWidth: .infinity)
                        .background(Color.white)
                        .cornerRadius(30)
                }
                .padding(.horizontal)

                Spacer()

                Text("Protótipo 1.0 - ResolveAí\nMurilo Farina | Mateus Bagli | Guilherme Cortez | Rodolpho Coller")
                    .font(.caption2)
                    .padding(.bottom)
                    .foregroundColor(.white)
                    .multilineTextAlignment(.center)
            }
            .padding()
        }
        
        
    }
}

#Preview {
    InitialView(flow: .constant(.start))
}

