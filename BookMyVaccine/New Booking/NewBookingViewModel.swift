import Combine
import MapKit

final class NewBookingViewModel: ObservableObject {
    @Published var searchText = "Hospital"
    @Published var places = [Hospital]()
    @Published var region = MKCoordinateRegion(
        center: .init(latitude: 35.689722, longitude: 139.692222),
        span: MKCoordinateSpan(latitudeDelta: 0.1, longitudeDelta: 0.1)
    )
    private var locationManager = LocationManager()
    private var subscribers = Set<AnyCancellable>()

    init() {
        $searchText
            .debounce(for: 1, scheduler: RunLoop.main)
            .filter(shouldIncludeInSearch)
            .sink(receiveValue: performSearch(searchText:))
            .store(in: &subscribers)
    }

    func shouldIncludeInSearch(text: String) -> Bool {
        !text.isEmpty && text.count > 3
    }

    func performSearch(searchText: String) {
        let request = MKLocalSearch.Request()
        request.naturalLanguageQuery = searchText
        request.region = region
        let search = MKLocalSearch(request: request)
        search.start { response, error in
            guard let response = response else { return }
            self.places = response.mapItems.compactMap {
                if let name = $0.name {
                    return Hospital(
                            name: name,
                            latitude: $0.placemark.coordinate.latitude,
                            longitude: $0.placemark.coordinate.longitude
                        )
                } else {
                    return nil
                }
            }
        }
    }
}
