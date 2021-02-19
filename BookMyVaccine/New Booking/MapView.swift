//
//  MapView.swift
//  BookMyVaccine
//
//  Created by Aviral Yadav on 20/02/21.
//

import SwiftUI
import MapKit

struct MapView: View {
    @ObservedObject private var locationManager = LocationManager()
    @State private var region = MKCoordinateRegion(
        center: .init(latitude: 35.689722, longitude: 139.692222),
        span: MKCoordinateSpan(latitudeDelta: 0.5, longitudeDelta: 0.5)
    )

    var body: some View {
        Map(coordinateRegion: $region)
            .ignoresSafeArea()
            .onChange(of: locationManager.lastLocation) {
                region.center = $0.coordinate
            }
    }
}

struct MapView_Previews: PreviewProvider {
    static var previews: some View {
        MapView()
    }
}
