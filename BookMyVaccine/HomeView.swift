//
//  HomeView.swift
//  BookMyVaccine
//
//  Created by Aviral Yadav on 21/02/21.
//

import SwiftUI

class currentUser: ObservableObject {
    @Published var user = User(name: "", email: "", id: 0)
}

struct HomeView: View {
    @State var demoLogin = false
    @ObservedObject var currentGiver = currentUser()
    var body: some View{
        if ( demoLogin) {
            RootView().ignoresSafeArea(.all, edges: .vertical).statusBar(hidden: true)
        } else {
            Onboarding(currentGiver: currentGiver, login: $demoLogin).ignoresSafeArea(.all, edges: .vertical).statusBar(hidden: true)
        }
    }
}

