//
//  AuthManager.swift
//  Project
//
//  Created by Turma02-10 on 28/07/25.
//

import Foundation
import Combine


class AuthManager: ObservableObject {
    static let shared = AuthManager()
    
    
    // @Published notifica qualquer View que esteja observando quando o valor de currentUser mudar.
    // Se for 'nil', ninguém está logado. Se tiver um objeto 'User', o usuário está logado.
    @Published var currentUser: User?
    
    private init() {
        // No futuro, você poderia adicionar aqui uma lógica para tentar carregar
        // um usuário que já estava logado da sessão anterior.
    }
    
    // MARK: - Funções de Autenticação
    
    /// Define o usuário atual, efetivamente "logando-o" no aplicativo.
    /// Esta função será chamada pelo RegistrationViewModel após um cadastro bem-sucedido.
    /// - Parameter user: O objeto User completo retornado pela API após o cadastro.
    func login(user: User) {
        DispatchQueue.main.async {
            self.currentUser = user
        }
    }
    
    /// Limpa o usuário atual, efetivamente "deslogando-o".
    func logout() {
        DispatchQueue.main.async {
            self.currentUser = nil
        }
    }
}
