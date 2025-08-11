//
//  HomePagePrestador.swift
//  ResolveAi
//
//  Created by Turma21-02 on 28/07/25.
//

import SwiftUI
import MapKit

struct HomePagePrestador: View {
    
    @Binding var selectedTab: Int
    @State private var showMenu = false
    @Binding var flow: AppFlow
    
    var body: some View {
        
        NavigationStack {
            
            VStack(alignment: .leading, spacing: 16) {
                
                Text("Olá, Prestador!")
                    .font(.title)
                    .bold()
                    .padding(.horizontal)
                
                Text("Meus Serviços")
                    .font(.subheadline)
                    .padding(.horizontal)
                
                Image("meusServicosImage")
                    .frame(width: .infinity)
                    .scaledToFill()
                .cornerRadius(24)
                .padding(.horizontal, 16)
                .onTapGesture {
                    selectedTab = 1
                }
                
                Text("Criar Serviço por Categoria")
                    .font(.subheadline)
                    .padding(.horizontal)
                    .padding(.top, 0)
                
                LazyVGrid(columns: [GridItem(), GridItem()], spacing: 16) {
                    
                    // Casa
                        VStack(alignment: .leading, spacing: 8) {
                            Image("ic-home")
                                .renderingMode(/*@START_MENU_TOKEN@*/.template/*@END_MENU_TOKEN@*/)
                                .resizable()
                                .scaledToFit()
                                .frame(width: 30, height: 30)
                                .foregroundColor(Color("AzulMedio"))

                            Text("Casa")
                                .font(.subheadline)
                                .bold()
                                .foregroundColor(.white)

                            Text("Cuidados com o lar")
                                .font(.caption2)
                                .foregroundColor(.white.opacity(0.8))
                        }
                        .padding()
                        .frame(maxWidth: .infinity, minHeight: 120)
                        .background(Color("AccentColor"))
                        .cornerRadius(20)
                        .onTapGesture {
                            selectedTab = 1
                        }
                    
                    
                    // Encanamentos
                        VStack(alignment: .leading, spacing: 8) {
                            Image("ic-encanamentos")
                                .resizable()
                                .scaledToFit()
                                .frame(width: 30, height: 30)
                            
                            Text("Encanamentos")
                                .font(.subheadline)
                                .bold()
                                .foregroundColor(.white)
                            
                            Text("Vazamentos e hidráulica")
                                .font(.caption2)
                                .foregroundColor(.white.opacity(0.8))
                        }
                        .padding()
                        .frame(maxWidth: .infinity, minHeight: 120)
                        .background(Color("AzulMedio"))
                        .cornerRadius(20)
                        .onTapGesture {
                            selectedTab = 1
                        }
                    

                    // Elétrica
                        VStack(alignment: .leading, spacing: 8) {
                            Image("ic-zap")
                                .resizable()
                                .scaledToFit()
                                .frame(width: 30, height: 30)

                            Text("Elétrica")
                                .font(.subheadline)
                                .bold()
                                .foregroundColor(.white)

                            Text("Instalações e reparos")
                                .font(.caption2)
                                .foregroundColor(.white.opacity(0.8))
                        }
                        .padding()
                        .frame(maxWidth: .infinity, minHeight: 120)
                        .background(Color("AzulEscuro"))
                        .cornerRadius(20)
                        .onTapGesture {
                            selectedTab = 1
                        }
                    
                    
                    // Pequenos Reparos
                        VStack(alignment: .leading, spacing: 8) {
                            Image("ic-tool")
                                .resizable()
                                .scaledToFit()
                                .frame(width: 30, height: 30)

                            Text("Pequenos Reparos")
                                .font(.subheadline)
                                .bold()
                                .foregroundColor(.white)

                            Text("Montagem e manutenção")
                                .font(.caption2)
                                .foregroundColor(.white.opacity(0.8))
                        }
                        .padding()
                        .frame(maxWidth: .infinity, minHeight: 120)
                        .background(Color("AzulPreto"))
                        .cornerRadius(20)
                        .onTapGesture {
                            selectedTab = 1
                        }
                }
                .padding(.horizontal)

                .toolbar {
                    ToolbarItem(placement: .navigationBarLeading) {
                        Button {
                            flow = .start
                        } label: {
                            Image("ic-menu")
                        }
                    }
                    
                    ToolbarItem(placement: .principal) {
                        Image("ic-logoAzul")
                    }
                    
                    ToolbarItem(placement: .navigationBarTrailing) {
                        Button {
                            selectedTab = 1
                        } label: {
                            Image("ic-foto")
                        }
                    }
                }
                .navigationBarTitleDisplayMode(.inline)
            }
        }
        
    }
}

#Preview {
    HomePagePrestador(selectedTab: .constant(0), flow: .constant(.start))
}
