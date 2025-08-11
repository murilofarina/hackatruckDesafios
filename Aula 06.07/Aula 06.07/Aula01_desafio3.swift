//
//  SwiftUIView.swift
//  Aula01
//
//  Created by Turma21-02 on 02/07/25.
//  Desafio 03

import SwiftUI

struct Aula01_desafio3: View {
    @State var name: String = ""
    @State private var showingAlert = false
        var body: some View {
            ZStack() {
                
                Image("hacka")
                    .opacity(0.15)
                
                Image("logohacka")
                    .resizable()
                    .scaledToFit()
                    .frame(width: 300)

                VStack() {
                    
                    Text("Bem vindo, \(name)")
                        .font(.largeTitle)
                    
                    TextField("Digite seu nome", text: $name)
                        .font(.subheadline)
                        .multilineTextAlignment(.center)
            
                    Spacer()
                    
                    Button("Entrar") {
                        showingAlert = true
                    }
                    .alert(isPresented: $showingAlert) {
                        Alert(title: Text("ALERTA!"), message: Text("Voce ira iniciar o desafio da aula agora"), dismissButton: .default(Text("Vamos lá!")))
                    }
                }
                .padding(80)
            }
        }
}

#Preview {
    Aula01_desafio3()
}
