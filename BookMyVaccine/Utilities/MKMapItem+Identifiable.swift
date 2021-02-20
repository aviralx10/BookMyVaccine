import class MapKit.MKMapItem

extension MKMapItem: Identifiable {
    public var id: String {
        "\(placemark.coordinate.latitude)\(placemark.coordinate.longitude)"
    }
}
