//
//  Register.swift
//  BookMyVaccine
//
//  Created by Aviral Yadav on 21/02/21.
//

import SwiftUI

struct Register: View {
    @State private var username: String = ""
    @State private var email: String = ""
    @State private var password: String = ""
    @State private var password2: String = ""
    @ObservedObject var currentGiver: currentUser
    @Binding var login: Bool

    var body: some View {
        VStack {
            Image("bookmyvaccine")
                .resizable()
                .aspectRatio(contentMode: .fit)
                .frame(width: UIScreen.main.bounds.width - 80)
                .padding(.bottom, 20)
            VStack(spacing: 25) {
                TextField("    Username", text: $username)
                    .frame(width: 260,height:30)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                TextField("    Email", text: $email)
                    .frame(width: 260,height:30)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                SecureField("    Password", text: $password)
                    .frame(width: 260,height:30)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                SecureField("    Confirm Password", text: $password2)
                    .frame(width: 260,height:30)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
            }
            
            Button(action: {
                login.toggle()
            }) {
                HStack {
                    Text("Sign up")
                        .fontWeight(.heavy)
                        .frame(width: 210, height: 30, alignment: .center)
                        .foregroundColor(.white)
                        .padding(.all)
                        .background(Color.blue)
                        .cornerRadius(16)
                }
                
            }
            

            
        }
    }
}


