import SwiftUI
import MapKit

struct NewBooking: View {
    @StateObject private var viewModel = NewBookingViewModel()

    var body: some View {
        VStack {
            MapView(region: $viewModel.region, places: viewModel.places) { place in
                if let location = place.name {
                    HospitalPin(hospitalName: location, isAvailable: true)
                }
            }
            SearchBar(text: $viewModel.searchText)
            List(viewModel.places) { place in
                if let name = place.name {
                    Text("\(name)")
                }
            }
        }
    }
}

