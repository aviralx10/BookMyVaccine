//
//  RootView.swift
//  BookMyVaccine
//
//  Created by Aviral Yadav on 21/02/21.
//

import SwiftUI

struct RootView: View {
    @State var demoLogin = false
    var body: some View{
        if demoLogin {
            MainView().ignoresSafeArea(.all, edges: .vertical).statusBar(hidden: true)
        } else {
            Onboarding(login: $demoLogin).ignoresSafeArea(.all, edges: .vertical).statusBar(hidden: true)
        }
    }
}

