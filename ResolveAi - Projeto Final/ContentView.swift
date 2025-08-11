import SwiftUI

enum AppFlow {
    case start
    case contratante
    case prestador
    case tabviewprestador
}

struct ContentView: View {
    
    @State private var flow: AppFlow = .start

    var body: some View {
        
        switch flow {
            case .start:
                InitialView(flow: $flow)
            case .contratante:
                TabViewContratante(flow: $flow)
            case .prestador:
                CadastroPrestador(flow: $flow)
            case .tabviewprestador:
                TabViewPrestador(flow: $flow)
        }
    }
}

#Preview {
    ContentView()
        .environmentObject(SearchViewModel())
}
