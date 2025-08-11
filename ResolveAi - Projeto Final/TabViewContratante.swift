import SwiftUI

struct TabViewContratante: View {
    
    @State private var selectedTab = 0
    @Binding var flow: AppFlow

    var body: some View {
        TabView(selection: $selectedTab) {
            HomePageView(selectedTab: $selectedTab, flow: $flow)
                .tabItem {
                    Image("ic-home")
                        .renderingMode(.template)
                }
                .tag(0)

            SearchPageView()
                .tabItem {
                    Image("ic-search")
                        .renderingMode(.template)
                }
                .tag(1)

            MapSearchView()
                .environmentObject(SearchViewModel())
                .tabItem {
                    Image("ic-maptab")
                        .renderingMode(.template)
                }
                .tag(2)

            ProfilePageView()
                .tabItem {
                    Image("ic-user")
                        .renderingMode(.template)
                }
                .tag(3)
        }
    }
}

#Preview {
    TabViewContratante(flow: .constant(.start))
    .environmentObject(SearchViewModel())

}
