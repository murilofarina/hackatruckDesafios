//
//  ContentView.swift
//  Aula 17.07 Desafio 2
//
//  Created by Turma21-02 on 17/07/25.
//

import SwiftUI
import AVFoundation

struct ContentView: View {

    @State var text: String = ""
    
    @State var utterance = AVSpeechUtterance()
    let synthesizer = AVSpeechSynthesizer()
    
    var body: some View {
        ZStack {
            
            LinearGradient(stops: [
                Gradient.Stop(color: .blue, location: 0),
                Gradient.Stop(color: .white, location: 0.4),
            ], startPoint: .top, endPoint: .bottom)
            .ignoresSafeArea()
            
            
            VStack {
                HStack {
                    AsyncImage(url: URL(string: "https://icons.veryicon.com/png/o/object/material-design-icons-1/text-to-speech.png")) { image in
                        image.resizable()
                    } placeholder: {
                        ProgressView()
                    }
                    .frame(width: 80, height: 80)
                    
                    Text("TEXTO PARA FALA")
                        .bold()
                        .font(.largeTitle)
                    
                } .padding(.horizontal, 16)
                Spacer()
            } .padding(.top, 36)
            
            
            
            VStack {
                
                TextField("Digite aqui", text: $text)
                    .multilineTextAlignment(.center)
                    .padding(16)
                    
                Divider()
                
                Button {
                    utterance = AVSpeechUtterance(string: text)
                    utterance.voice = AVSpeechSynthesisVoice(language: "en-GB")
                    synthesizer.speak(utterance)
        
                    utterance.rate = 0.8
                    utterance.pitchMultiplier = 0.8
                    utterance.postUtteranceDelay = 0.2
                    utterance.volume = 0.8
                } label: {
                    HStack{
                        Image(systemName: "microphone.fill")
                            .imageScale(.large)
                            .foregroundStyle(.tint)
                        Text("Sintetizar")
                            .bold()
                            .font(/*@START_MENU_TOKEN@*/.title/*@END_MENU_TOKEN@*/)
                            .padding(16)
                    }
                }
            }
        }
        
    }
}
#Preview {
    ContentView()
}
