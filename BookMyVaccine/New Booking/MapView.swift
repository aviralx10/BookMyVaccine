//
//  MapView.swift
//  BookMyVaccine
//
//  Created by Aviral Yadav on 20/02/21.
//

import SwiftUI
import MapKit

struct MapView: View {
    @Binding var region: MKCoordinateRegion

    var body: some View {
        Map(coordinateRegion: $region)
            .ignoresSafeArea()
    }
}

struct MapView_Previews: PreviewProvider {
    static var previews: some View {
        MapView(
            region: .constant(
                MKCoordinateRegion(
                    center: .init(latitude: 35.689722, longitude: 139.692222),
                    span: MKCoordinateSpan(latitudeDelta: 0.5, longitudeDelta: 0.5)
                )
            )
        )
    }
}
