//
//  vizualizarPersonagem.swift
//  Aula 14.07
//
//  Created by Turma21-02 on 14/07/25.
//

import SwiftUI

struct vizualizarCelular: View {
    
    @State var recebe: Cel = Cel(nomeCelular: "Iphone", linha: "13", marca: "Apple", celulares: [Celulares(linha: "13", modelo: "Pro", cor: "Titanium White", preco: 3499, foto: "https://carrefourbr.vtexassets.com/arquivos/ids/181459796/image-0.jpg?v=638696070131730000")])
    
    var body: some View {
        
        ZStack {
            
            VStack {
                ForEach(recebe.celulares, id: \.self) { c in
                    VStack {
                        AsyncImage(url: URL(string: c.foto!)) { image in
                            image.resizable()
                        } placeholder: {
                            ProgressView()
                        }
                        .frame(width: 280, height: 280)
                        .cornerRadius(16)
                        .padding(10)
                        
                        Text(recebe.nomeCelular!)
                            .foregroundStyle(.white)
                            .font(.title)
                        Spacer()
                        
                        VStack(alignment: .leading) {
                            HStack {
                                Text("Marca:   ")
                                    .foregroundStyle(.black)
                                    .font(.title)
                                Text(recebe.marca!)
                                    .foregroundStyle(.black)
                            }
                            HStack {
                                Text("Linha:   ")
                                    .foregroundStyle(.black)
                                    .font(.title)
                                Text(c.linha!)
                                    .foregroundStyle(.black)
                            }
                            HStack {
                                Text("Cor:   ")
                                    .foregroundStyle(.black)
                                    .font(.title)
                                Text(c.cor!)
                                    .foregroundStyle(.black)
                            }
                            HStack {
                                Text("Preco: ")
                                    .foregroundStyle(.black)
                                    .font(.title)
                                Text("R$ \(String(format: "%.2f", c.preco!))")
                                        .foregroundStyle(.black)
                                }
                            }
                        }
                        
                    }
                }
            } .padding(100)
        }
    }
#Preview {
    vizualizarCelular()
}
