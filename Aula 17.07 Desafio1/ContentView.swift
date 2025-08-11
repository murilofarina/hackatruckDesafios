//
//  ContentView.swift
//  Aula 17.07
//
//  Created by Turma21-02 on 17/07/25.
//

import SwiftUI
import GoogleGenerativeAI

struct ContentView: View {
    
    let model = GenerativeModel(name: "gemini-2.0-flash", apiKey: APIKey.default)
    
    @State var textInput = ""
    @State var aiResponse = "..."
    
    func sendMessage() {
        
        aiResponse = ""
        
        let prompt = """
                Melhore o seguinte currículo com foco em profissionalismo, clareza e impacto. Corrija erros gramaticais, organize as informações em seções apropriadas (como Objetivo, Experiência Profissional, Formação Acadêmica, Habilidades, Idiomas, Certificações), reescreva usando linguagem formal e destaque pontos fortes. Retorne apenas o currículo pronto, sem explicações nem comentários extras.

                Currículo original:
                \(textInput)
                """
        
        Task {
            do {
                let response = try await model.generateContent(textInput)
                
                guard let text = response.text else {
                    textInput = "Sorry, I could not process that.\nPlease try again."
                    return
                }
                
                textInput = ""
                aiResponse = text
                
            } catch {
                aiResponse = "Something went wrong!\n\(error.localizedDescription)"
            }
        }
    }
    
    var body: some View {
    
            VStack {
                Image("Image")
                Spacer()
                
                Text("Insira seu curriculo:")
                    .font(.title2)
            
                TextEditor(text: $textInput)
                                .frame(height: 160)
                                .padding()
                                .overlay(RoundedRectangle(cornerRadius: 16).stroke(Color.gray.opacity(0.5)))
                                .padding(.bottom)
                                .padding(.horizontal, 24)
                                .padding(.top)
                                
                
                Button("Gerar Currículo") {
                               sendMessage()
                           }
                            .frame(width: 256)
                           .padding()
                           .background(Color("Color"))
                           .foregroundColor(.white)
                           .cornerRadius(16)
                
                ZStack {
                                RoundedRectangle(cornerRadius: 16)
                                    .stroke(Color.gray.opacity(0.5))
                                    .background(Color.white.cornerRadius(16))
                                    
                                ScrollView {
                                        Text(aiResponse)
                                            .padding()
                                            .frame(maxWidth: .infinity, alignment: .topLeading)
                                    }
                                }
                                .frame(height: 240)
                                .padding(.horizontal, 24)
                                .padding(.top, 10)
                                
                                Spacer(minLength: 24)
            }
    }
}

#Preview {
    ContentView()
}
