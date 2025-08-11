//
//  ContratoView.swift
//  projeto
//
//  Created by Turma02-26 on 28/07/25.
//

import SwiftUI

struct ContratoView: View {
    var user: User

    var body: some View {
        VStack(spacing: 20) {
 
            VStack(spacing: 8) {
                Image(systemName: "exclamationmark.circle")
                    .font(.system(size: 30))
                    .foregroundColor(.blue)
                
                Text("Confirmar Contratação")
                    .font(.title2)
                    .foregroundColor(.blue)
                    .bold()
            }
 
            VStack(alignment: .leading, spacing: 15) {
                HStack {
                    Text("Prestador:")
                        .bold()
                    Text(user.name)
                }
                
                HStack {
                    Text("Serviço:")
                        .bold()
                    Text(user.occupation!)
                }
                
                HStack {
                    Text("Localização:")
                        .bold()
                    Text("\(user.city ?? ""), \(user.state ?? "")")
                }
                
                HStack {
                    Text("Preço:")
                        .bold()
                    Text(String(user.hourValue!))
                }
            }
            
            .frame(maxWidth: .infinity, alignment: .leading)
            .padding(.horizontal)

            // Mensagem de confirmação
            Text("Você está prestes a contratar este serviço.\nConfirma que deseja continuar?")
                .font(.footnote)
                .foregroundColor(.gray)
                .multilineTextAlignment(.center)
                .padding(.horizontal)

            // Botão de confirmação
            Button(action: {
                // ação ao confirmar
            }) {
                Text("Confirmar Contrato")
                    .foregroundColor(.white)
                    .frame(maxWidth: .infinity)
                    .padding()
                    .background(Color.blue)
                    .cornerRadius(30)
            }
            .padding(.horizontal)
        }
        .padding()
    }
}
