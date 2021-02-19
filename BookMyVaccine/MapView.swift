//
//  MapView.swift
//  BookMyVaccine
//
//  Created by Aviral Yadav on 20/02/21.
//

import SwiftUI
import MapKit

struct MapView: View {
    var body: some View {
        TabView{
            Text("Item1")
                .tabItem {
                    VStack{
                        Image(systemName:"pencil")
                        Text("New Booking")
                    }
                
                }.tag(1)
            Text("Item2")
                .tabItem {
                    VStack{
                        Image(systemName:"heart.text.square.fill")
                        Text("My Bookings")
                    }
                }.tag(2)
            
        }
    }
}

struct MapView_Previews: PreviewProvider {
    static var previews: some View {
        MapView()
    }
}
