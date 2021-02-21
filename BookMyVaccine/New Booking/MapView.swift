//
//  MapView.swift
//  BookMyVaccine
//
//  Created by Aviral Yadav on 20/02/21.
//

import SwiftUI
import MapKit

struct MapView<Annotation: View>: View {
    @Binding var region: MKCoordinateRegion
    let places: [Hospital]
    let annotationContent: (Hospital) -> Annotation

    init(
        region: Binding<MKCoordinateRegion>,
        places: [Hospital],
        @ViewBuilder annotationContent: @escaping (Hospital) -> Annotation
    ) {
        self._region = region
        self.places = places
        self.annotationContent = annotationContent
    }

    var body: some View {
        Map(
            coordinateRegion: $region,
            annotationItems: places
        ) { place in
            MapAnnotation(
                coordinate: CLLocationCoordinate2D(latitude: place.latitude, longitude: place.longitude),
                content: { annotationContent(place) }
            )
        }
        .ignoresSafeArea()
    }
}
