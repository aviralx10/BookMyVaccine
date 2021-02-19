//
//  RootView.swift
//  BookMyVaccine
//
//  Created by Neil Jain on 2/20/21.
//

import SwiftUI

struct RootView: View {
    var body: some View {
        TabView {
            MapView()
                .tabItem {
                    VStack {
                        Image(systemName:"pencil")
                        Text("New Booking")
                    }

                }.tag(1)
            Text("Item2")
                .tabItem {
                    VStack {
                        Image(systemName:"heart.text.square.fill")
                        Text("My Bookings")
                    }
                }.tag(2)
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        RootView()
    }
}
