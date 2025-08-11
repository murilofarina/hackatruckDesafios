//
//  vizualizarMusica.swift
//  Aula 07.07
//
//  Created by Turma21-02 on 07/07/25.
//

import SwiftUI

struct vizualizarMusica: View {
    
    @State var recebe: Musica =  Musica(id: 1, nome: "Fade to Black", artista: "Metallica", capa:
                                            "https://i.scdn.co/image/ab67616d00001e02533fd0b248052d04e6b732c0")
    var body: some View {
        ZStack() {
            LinearGradient(stops: [
                Gradient.Stop(color: .blue, location: 0.00),
                Gradient.Stop(color: .black, location: 0.7),
            ], startPoint: .top, endPoint: .bottom)
            .ignoresSafeArea()
            
            VStack() {
                AsyncImage(url: URL(string: recebe.capa)) { image in
                    image.resizable()
                } placeholder: {
                    ProgressView()
                }
                .frame(width: 200, height: 200)
                Text(recebe.nome)
                    .foregroundStyle(.white)
                    .font(.title)
                Text(recebe.artista)
                    .foregroundStyle(.white)
                Spacer()
                HStack() {
                    Image(systemName: "shuffle")
                        .resizable()
                        .scaledToFit()
                        .frame(width: 40)
                        .foregroundStyle(.white)
                        .padding(10)
                    Image(systemName: "backward.end.fill")
                        .resizable()
                        .scaledToFit()
                        .frame(width: 40)
                        .foregroundStyle(.white)
                    Image(systemName: "play.fill")
                        .resizable()
                        .scaledToFit()
                        .frame(width: 40)
                        .foregroundStyle(.white)
                        .padding(30)
                    Image(systemName: "forward.end.fill")
                        .resizable()
                        .scaledToFit()
                        .frame(width: 40)
                        .foregroundStyle(.white)
                    Image(systemName: "repeat")
                        .resizable()
                        .scaledToFit()
                        .frame(width: 40)
                        .foregroundStyle(.white)
                        .padding(10)
                } .padding(10)
                
                
            } .padding(100)
        }
        
    }
    
}
    
    #Preview {
        vizualizarMusica()
    }
