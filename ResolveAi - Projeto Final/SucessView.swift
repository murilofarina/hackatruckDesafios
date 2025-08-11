

import Foundation
import SwiftUI

struct SuccessView: View {

let user: User



var body: some View {

VStack(spacing: 20) {

Text("Usuário criado com sucesso!")

.font(.title)

.foregroundColor(.green)



Text("Nome: (user.name)")

Text("Cidade: (user.city) - (user.state)")

Text("Ocupação: (user.occupation)")

Text("Valor/hora: R$ (user.hourValue)")

Text("Bio: (user.bio)")

}

.padding()

}

}
