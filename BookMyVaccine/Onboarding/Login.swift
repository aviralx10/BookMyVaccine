//
//  Login.swift
//  BookMyVaccine
//
//  Created by Aviral Yadav on 21/02/21.
//

import Combine
import SwiftUI

struct Login: View{
    @AppStorage("userID") var userID: String = ""
    @StateObject private var viewModel = LoginViewModel()
    @State private var username: String = ""
    @Binding var login: Bool

    var body: some View {
        VStack {
            Image("bookmyvaccine")
                .resizable()
                .aspectRatio(contentMode: .fit)
                .frame(width: UIScreen.main.bounds.width - 80)
                .padding(.bottom, 20)

            VStack(spacing: 25) {
                TextField("Full Name", text: $username)
                    .frame(width: 260,height:30)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
            }
            
            Button(action: {
                viewModel.createNewUser(with: username) {
                    userID = $0.id ?? ""
                    login.toggle()
                }
            }) {
                HStack {
                    Text("Login")
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

final class LoginViewModel: ObservableObject {
    var subscribers = Set<AnyCancellable>()
    func createNewUser(with name: String, completion: @escaping (User) -> Void) {
        let user = User(name: name, appointments: [])
        let url = URL(string: "\(URL.current)/patients")!
        NetworkManager().create(user, on: url)
            .sink(receiveCompletion: { _ in

            }
            , receiveValue: { user in
                completion(user)
            })
            .store(in: &subscribers)
    }
}

