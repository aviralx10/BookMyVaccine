import SwiftUI
import MapKit

struct NewBooking: View {
    @StateObject private var viewModel = NewBookingViewModel()
    @State private var selectedHospital: String?
    @State private var showSelectedHospital: Bool = false

    var body: some View {
        VStack {
            MapView(region: $viewModel.region, places: viewModel.places) { place in
                if let location = place.name! {
                    if location == selectedHospital {
                        HospitalDetails(hospitalName: location) {
                            showSelectedHospital = true
                        }
                    } else if selectedHospital == nil {
                        HospitalPin(hospitalName: location, highlighted: false)
                    }
                }
            }
            SearchBar(text: $viewModel.searchText)
            List(viewModel.places) { place in
                if let name = place.name {
                    if selectedHospital == name {
                        navLink(for: name)
                    } else {
                        Button {
                            centerInHospital(place: place)
                        } label: {
                            Text("\(name)")
                        }
                    }
                }
            }
        }
    }

    func navLink(for name: String) -> some View {
        NavigationLink(
            destination: HospitalBooking(hospitalName: selectedHospital!),
            isActive: $showSelectedHospital
        ) {
            Text("\(name)")
                .bold()
        }
    }

    func centerInHospital(place: MKMapItem) {
        guard let name = place.name else { return }
        if selectedHospital == name {
            withAnimation {
                selectedHospital = nil
            }
        } else {
            selectedHospital = name
            guard let location = place.placemark.location else { return }
            let latitude = location.coordinate.latitude
            let longitude = location.coordinate.longitude + 0.01
            withAnimation {
                viewModel.region = MKCoordinateRegion(
                    center: .init(latitude: latitude, longitude: longitude),
                    span: MKCoordinateSpan(latitudeDelta: 0.05, longitudeDelta: 0.05)
                )
            }
        }
    }
}

struct HospitalDetails: View {
    let hospitalName: String
    let bookButtonPressed: () -> Void
    var body: some View {
        HStack {
            Rectangle()
                .foregroundColor(.clear)
                .frame(width: 200, height: 200)
            HospitalPin(hospitalName: hospitalName, highlighted: true)
            VStack {
                Text(hospitalName)
                    .foregroundColor(.black)
                    .padding()
                    .background(Color.white)
                    .cornerRadius(10)
                Button {
                    bookButtonPressed()
                } label: {
                    Label("Book", systemImage: "pencil")
                }
                .foregroundColor(.white)
                .padding()
                .background(Color.accentColor)
                .cornerRadius(10)
            }
            .frame(width: 200, height: 200)
        }
        .padding()
    }
}

struct HospitalDetails_Previews: PreviewProvider {
    static var previews: some View {
        HospitalDetails(hospitalName: "North York General Hospital") {
            print("Booking...")
        }
        .background(Color.black)
        .previewLayout(.sizeThatFits)
    }
}

