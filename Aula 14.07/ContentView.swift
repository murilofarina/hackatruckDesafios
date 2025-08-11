//
//  ContentView.swift
//  Aula 14.07
//
//  Created by Turma21-02 on 14/07/25.
//

import SwiftUI

struct ContentView: View {
    
    @StateObject var viewModel = ViewModel()
    
    var body: some View {
        
        NavigationStack {
            
            ZStack{
                Color.black
                    .ignoresSafeArea()
                
                VStack {
                    AsyncImage(url: URL(string: "https://c4.wallpaperflare.com/wallpaper/140/46/538/game-of-thrones-westeros-wallpaper-preview.jpg")) { image in
                        image.resizable()
                    } placeholder: {
                        ProgressView()
                    }
                    .scaledToFit()
                    .frame(width: 550)
                    .ignoresSafeArea()
                    .opacity(0.3)
                    Spacer()
                }
                
                VStack{
                    AsyncImage(url: URL(string: "https://www.pngall.com/wp-content/uploads/2016/05/Game-of-Thrones-Logo.png")) { image in
                        image.resizable()
                    } placeholder: {
                        ProgressView()
                    }
                    .scaledToFit()
                    .frame(width: 300)
                    .padding(40)
                    Spacer()
            
                    ScrollView {
                        VStack(alignment: .leading){
                            Spacer()
                            ForEach(viewModel.personagens) { item in
                                NavigationLink(destination: vizualizarPersonagem(recebe: item)) {
                                    HStack {
                                        AsyncImage(url: URL(string: item.imageUrl!)) { image in
                                            image.resizable()
                                        } placeholder: {
                                            ProgressView()
                                        }
                                        .frame(width: 50, height: 50)
                                        .cornerRadius(10)
                                        .padding()
                                        VStack(alignment: .leading) {
                                            Text(item.fullName!)
                                                .foregroundStyle(.white)
                                                .font(.headline)
                                            Text(item.title!)
                                                .foregroundStyle(.white)
                                        }
                                    }
                                }
                            }
                        } .padding(72)
                    }
                }
            }
        }
        .onAppear(){
            viewModel.fetch()
        }
    }
}

#Preview {
    ContentView()
}
