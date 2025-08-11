
import SwiftUI

struct TabViewPrestador: View {
    
    @State private var selectedTab = 0
    
    @Binding var flow: AppFlow
    
    var body: some View {
        
        TabView(selection: $selectedTab) {
            
            HomePagePrestador(selectedTab: $selectedTab, flow: $flow)
                .tabItem {
                    Image("ic-home")
                        .renderingMode(.template)
                }
                .tag(0)
            ProfilePagePrestador()
                .tabItem {
                    Image("ic-user")
                        .renderingMode(.template)
                }
                .tag(1)
        }
    }
}

#Preview {
    TabViewPrestador(flow: .constant(.start))
    .environmentObject(SearchViewModel())

}
