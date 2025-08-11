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
                
                VStack {
                    AsyncImage(url: URL(string: "https://media.istockphoto.com/id/1652302318/vector/abstract-gray-and-white-color-gradient-background-vector-illustration.jpg?s=612x612&w=0&k=20&c=PTPlmFhCfYkGpnxxcfN_K8GL17rwHzTl3hj9KA96B5Y=")) { image in
                        image.resizable()
                    } placeholder: {
                        ProgressView()
                    }
                    .scaledToFit()
                    .frame(width: 455)
                    .ignoresSafeArea()
                    .opacity(0.4)
                    Spacer()
                }
                
                VStack{
                    AsyncImage(url: URL(string: "https://upload.wikimedia.org/wikipedia/commons/thumb/2/25/IPhonelogo.svg/2560px-IPhonelogo.svg.png")) { image in
                        image.resizable()
                    } placeholder: {
                        ProgressView()
                    }
                    .scaledToFit()
                    .frame(width: 180)
                    .padding(70)
                    Spacer()
            
                    ScrollView {
                        VStack{
                            Spacer()
                            ForEach(viewModel.cels, id: \.self) { item in
                                ForEach(item.celulares, id: \.self) { c in
                                    NavigationLink(destination: vizualizarCelular(recebe: item)) {
                                        HStack {
                                            AsyncImage(url: URL(string: c.foto!)) { image in
                                                image.resizable()
                                            } placeholder: {
                                                ProgressView()
                                            }
                                            .frame(width: 150, height: 150)
                                            .cornerRadius(16)
                                            .padding()
                                            VStack(alignment: .leading) {
                                                Text(item.nomeCelular!+" "+c.modelo!)
                                                    .foregroundStyle(.black)
                                                    .font(.headline)
                                                Text(item.marca!)
                                                    .foregroundStyle(.black)
                                            }
                                        }
                                    }
                                }
                            }
                        } .padding(48)
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
