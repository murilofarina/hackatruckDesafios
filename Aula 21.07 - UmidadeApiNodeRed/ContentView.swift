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
    
        ZStack {
            VStack {
                Text("Umidade")
                    .font(.largeTitle)
                    .bold()
                Spacer()
            } .padding(36)
            VStack {
                ScrollView {
                    ForEach(viewModel.arrayUmidade, id: \.self) { item in
                        VStack(alignment: .leading) {
                            Text(item.umidade!)
        
                        }
                        
                }
                }
                    
            } .frame(width: 256, height: 512)
                .background(.color)
                .cornerRadius(36)
            Spacer()
        
            VStack {
                Spacer()
                AsyncImage(url: URL(string: "https://png.pngtree.com/thumb_back/fh260/background/20240424/pngtree-transparent-water-splash-and-wave-on-light-background-ai-image_15665687.jpg")) { image in
                    image.resizable()
                } placeholder: {
                    ProgressView()
                }
                .ignoresSafeArea()
                .scaledToFit()
                .frame(width: 400)
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
