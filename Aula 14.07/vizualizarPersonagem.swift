//
//  vizualizarPersonagem.swift
//  Aula 14.07
//
//  Created by Turma21-02 on 14/07/25.
//

import SwiftUI

struct vizualizarPersonagem: View {
    
    @State var recebe: Got = Got(id: 0, firstName: "Daenerys", lastName: "Targaryen", fullName: "Daenerys Targaryen", title: "Mother of Dragons", family: "House Targaryen", image: "", imageUrl: "https://thronesapi.com/assets/images/daenerys.jpg")
    
    var body: some View {
        ZStack {
            Color.black
                .ignoresSafeArea()
            
            VStack {
                AsyncImage(url: URL(string: "https://c4.wallpaperflare.com/wallpaper/140/46/538/game-of-thrones-westeros-wallpaper-preview.jpg")) { image in
                    image.resizable()
                } placeholder: {
                    ProgressView()
                }
                .scaledToFill()
                .frame(width: 550)
                .ignoresSafeArea()
                .opacity(0.2)
            }
            
            VStack {
                
                AsyncImage(url: URL(string: recebe.imageUrl!)) { image in
                    image.resizable()
                } placeholder: {
                    ProgressView()
                }
                .frame(width: 280, height: 280)
                .cornerRadius(16)
                .padding(10)
                
                Text(recebe.fullName!)
                    .foregroundStyle(.white)
                    .font(/*@START_MENU_TOKEN@*/.title/*@END_MENU_TOKEN@*/)
                Spacer()
                
                HStack {
                    Text("Family:   ")
                        .foregroundStyle(.white)
                        .font(.title)
                    Text(recebe.family!)
                        .foregroundStyle(.white)
                }
                HStack {
                    Text("Title:   ")
                        .foregroundStyle(.white)
                        .font(.title)
                    Text(recebe.title!)
                        .foregroundStyle(.white)
                }
            } .padding(120)
        }
        
    }
}

#Preview {
    vizualizarPersonagem()
}
