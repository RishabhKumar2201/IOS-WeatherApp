import SwiftUI

struct ListView: View {

    @StateObject private var viewModel = ListViewModel()
    @Environment(\.dismiss) private var dismiss

    var body: some View {
        NavigationStack {
            ZStack {
<<<<<<< HEAD
                Color("backgroundColor", bundle: nil).ignoresSafeArea()
                
                List {
                    ForEach(viewModel.filteredLocations) { location in
                        NavigationLink(destination: DetailView(location: location, weatherService: WeatherService(networkService: HttpNetworking()))) {
                            
                            HStack {
                                Text(location.name)
                                    .font(.headline)
                                    .foregroundStyle(Color.white)
                                
                                Spacer()
                                
=======
                Color("backgroundColor", bundle: nil)
                    .ignoresSafeArea()

                List {
                    ForEach(viewModel.filteredLocations) { location in
                        NavigationLink(
                            destination: DetailView(location: location)
                        ) {
                            HStack {
                                Text(location.name)
                                    .font(.headline)
                                    .foregroundStyle(.white)

                                Spacer()

>>>>>>> main
                                Image(systemName: location.weather.icon)
                                    .foregroundColor(.yellow)
                            }
                        }
                        .listRowBackground(Color.clear)
                        .frame(height: 60)
                    }
                }
<<<<<<< HEAD
                .navigationBarBackButtonHidden(true)
                .toolbar(content: {
=======
                .scrollContentBackground(.hidden)
                .navigationBarBackButtonHidden(true)
                .toolbar {
>>>>>>> main
                    ToolbarItem(placement: .topBarLeading) {
                        Button {
                            dismiss()
                        } label: {
                            Image(systemName: "chevron.backward")
                                .foregroundStyle(.white)
                        }
                    }
<<<<<<< HEAD
                    
                    ToolbarItem(placement: .principal) {
                        Text("Locations").foregroundColor(.white)
                    }
                })
                .searchable(text: $viewModel.searchText, placement: .navigationBarDrawer(displayMode: .always), prompt: "Search location or city")
            }
            .scrollContentBackground(.hidden)
=======

                    ToolbarItem(placement: .principal) {
                        Text("Locations")
                            .foregroundStyle(.white)
                    }
                }
                .searchable(
                    text: $viewModel.searchText,
                    placement: .navigationBarDrawer(displayMode: .always),
                    prompt: "Search location or city"
                )
            }
>>>>>>> main
        }
    }
}

#Preview {
    ListView()
}
