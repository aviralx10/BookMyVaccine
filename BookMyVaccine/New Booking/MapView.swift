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
    let places: [MKMapItem]
    let annotationContent: (MKMapItem) -> Annotation

    init(
        region: Binding<MKCoordinateRegion>,
        places: [MKMapItem],
        @ViewBuilder annotationContent: @escaping (MKMapItem) -> Annotation
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
                coordinate: place.placemark.coordinate,
                content: { annotationContent(place) }
            )
        }
        .ignoresSafeArea()
    }
}
