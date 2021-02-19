import CoreLocation
import Foundation

final class LocationManager: NSObject, ObservableObject {

    @Published var isAuthorized = false
    @Published var lastLocation = CLLocation(latitude: 0, longitude: 0)

    private let manager: CLLocationManager

    override init() {
        let manager = CLLocationManager()
        manager.desiredAccuracy = kCLLocationAccuracyThreeKilometers
        manager.requestWhenInUseAuthorization()
        self.manager = manager
        super.init()
        manager.delegate = self
    }
}

extension LocationManager: CLLocationManagerDelegate {
    func locationManagerDidChangeAuthorization(_ manager: CLLocationManager) {
        switch manager.authorizationStatus {
        case .authorizedAlways, .authorizedWhenInUse:
            isAuthorized = true
            manager.startUpdatingLocation()
        default:
            isAuthorized = false
        }
    }

    func locationManager(
        _ manager: CLLocationManager,
        didUpdateLocations locations: [CLLocation]
    ) {
        if let location = locations.last {
            lastLocation = location
        }
    }
}
