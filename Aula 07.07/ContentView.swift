//
//  ContentView.swift
//  Aula 07.07
//
//  Created by Turma21-02 on 07/07/25.
//

import SwiftUI

struct Musica: Identifiable {
    var id: Int
    var nome: String
    var artista: String
    var capa: String
}

struct ContentView: View {
    
    var arrayMusicas = [
        Musica(id: 1, nome: "Fade to Black", artista: "Metallica", capa:
                "https://i.scdn.co/image/ab67616d00001e02533fd0b248052d04e6b732c0"),
        Musica(id: 2, nome: "Listen Up - Remastered", artista: "Oasis", capa: "https://i1.sndcdn.com/artworks-HQ0XfhMRqSoS-0-t500x500.jpg"),
        Musica(id: 3, nome: "Teste 1", artista: "Artista ficticio", capa: ""), Musica(id: 4, nome: "Teste 1", artista: "Artista ficticio", capa: ""),
        Musica(id: 5, nome: "Teste 1", artista: "Artista ficticio", capa: ""), Musica(id: 6, nome: "Teste 1", artista: "Artista ficticio", capa: ""),
        Musica(id: 7, nome: "Teste 1", artista: "Artista ficticio", capa: ""), Musica(id: 8, nome: "Teste 1", artista: "Artista ficticio", capa: ""),
    ]
    
    var body: some View {
        
        NavigationStack {
            ZStack{
                
                LinearGradient(stops: [
                    Gradient.Stop(color: .blue, location: 0.00),
                    Gradient.Stop(color: .black, location: 0.7),
                ], startPoint: .top, endPoint: .bottom)
                .ignoresSafeArea()
                
                ScrollView {
                    VStack(alignment: .leading){
                        AsyncImage(url: URL(string: "https://www.itaipuparquetec.org.br/wp-content/uploads/2024/02/HACKATRUCK_22022024-2-scaled.jpg")) { image in
                            image.resizable()
                        } placeholder: {
                            ProgressView()
                        }
                        .frame(width: 200, height: 200)
                        
                        VStack{
                            Text("HackaSong")
                                .foregroundStyle(.white)
                                .font(.largeTitle)
                            HStack() {
                                AsyncImage(url: URL(string: "https://www.itaipuparquetec.org.br/wp-content/uploads/2024/02/HACKATRUCK_22022024-2-scaled.jpg")) { image in
                                    image.resizable()
                                } placeholder: {
                                    ProgressView()
                                }
                                .frame(width: 30, height: 30)
                                
                                Text("HackaFM")
                                    .foregroundStyle(.white)
                                
                            }
                            Spacer()
                        }
                        
                    }
                    
                    VStack {
                        ForEach(arrayMusicas) { item in
                            NavigationLink(destination: vizualizarMusica(recebe: item)) {
                                HStack {
                                    AsyncImage(url: URL(string: item.capa)) { image in
                                        image.resizable()
                                    } placeholder: {
                                        ProgressView()
                                    }
                                    .frame(width: 50, height: 50)
                                    
                                    VStack(alignment: .leading) {
                                        Text(item.nome)
                                            .foregroundStyle(.white)
                                            .font(.headline)
                                        Text(item.artista)
                                            .foregroundStyle(.white)
                                    }
                                    Spacer()
                                }
                                
                            }
                        }
                        .padding(20)
                        
                        VStack() {
                            HStack() {
                                Text("Sugeridos")
                                    .foregroundStyle(.white)
                                    .font(.title)
                                Spacer()
                            } .padding(20)
                            HStack() {
                                AsyncImage(url: URL(string: "https://t3.ftcdn.net/jpg/04/04/55/62/360_F_404556246_wzUy9XVbgxet7LI5XqgEb95zXh0jyY6l.jp")) { image in
                                    image.resizable()
                                } placeholder: {
                                    ProgressView()
                                }
                                .frame(width: 30, height: 30)
                                
                            }
                        }
                        
                    }
                }
            }
        }
    }
}
#Preview {
    ContentView()
}
