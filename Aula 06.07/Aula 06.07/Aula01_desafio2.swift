//
//  Aula01_desafio2.swift
//  Aula01
//
//  Created by Turma21-02 on 02/07/25.
//  Desafio 02

import SwiftUI

struct Aula01_desafio2: View {
    var body: some View {
        HStack{
            VStack{
                Image("Image")
                    .resizable()
                    .frame(width: 120, height: 120)
                    .scaledToFit()
                    .clipShape(Capsule())
            }
            VStack(spacing: 10){
                    Text("HackaTruck")
                        .foregroundStyle(.red)
                    Text("77 Universidades")
                        .foregroundStyle(.blue)
                    Text("5 regioes do Brasil")
                        .foregroundStyle(.yellow)
            }
            .padding()
            
        }
        .padding()
    }
}

#Preview {
    Aula01_desafio2()
}
