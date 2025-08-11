import SwiftUI
import MapKit

struct MapSearchView: View {
    
    @EnvironmentObject var viewModel: SearchViewModel
    @State private var showingSheet = false
    @State private var selectedUser: User?

    @State private var position = MapCameraPosition.region(
        MKCoordinateRegion(
            center: CLLocationCoordinate2D(latitude: -14.2350, longitude: -51.9253),
            span: MKCoordinateSpan(latitudeDelta: 40, longitudeDelta: 40)
        )
    )

    var body: some View {
        NavigationStack {
            ZStack(alignment: .top) {
                
                Map(position: $position) {
                    ForEach(viewModel.filteredUsers) { user in
                        if let lat = user.latitude, let lon = user.longitude {
                            Annotation(user.name, coordinate: CLLocationCoordinate2D(latitude: lat, longitude: lon)) {
                                Image(systemName: "mappin.circle.fill")
                                    .font(.title)
                                    .foregroundStyle(Color("AzulMedio"))
                                    .onTapGesture {
                                        
                                        selectedUser = user
                                        showingSheet = true
                                    }
                            }
                        }
                    }
                }
                .ignoresSafeArea()
                
                Picker("Categoria", selection: $viewModel.selectedCategory) {
                    ForEach(viewModel.categories, id: \.self) { category in
                        Text(category)
                    }
                }
                .pickerStyle(.menu)
                .padding()
                .background(.regularMaterial)
                .cornerRadius(10)
                .shadow(radius: 5)
                .padding(.top)
                
            }
        }
        .toolbarBackground(.hidden, for: .navigationBar)
        .sheet(item: $selectedUser) { user in
            
            SheetMapa(usuario: .constant(user))
        }
    }
}

#Preview {
   
    MapSearchView()
        .environmentObject(SearchViewModel())
}
