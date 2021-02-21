//
//  HospitalBooking.swift
//  BookMyVaccine
//
//  Created by Kevin Peng on 2021-02-21.
//

import Combine
import SwiftUI

final class HospitalBookingViewModel: ObservableObject {
    var subscribers = Set<AnyCancellable>()

    func fetchAppointments(for hospitalName: String) {
        let baseURL = URL(string: "https://bookmyvaccine.herokuapp.com/hospitals/appointments")!
        var urlComponents = URLComponents(url: baseURL, resolvingAgainstBaseURL: false)!
        urlComponents.queryItems = [
            URLQueryItem(name: "hospitalName", value: hospitalName)
        ]
        let url = urlComponents.url!
        NetworkManager().fetch(
            BookedAppointment.self,
            from: url
        )
        .sink(
            receiveCompletion: { _ in

            },
            receiveValue: { _ in

            }
        )
        .store(in: &subscribers)
    }
}

struct HospitalBooking: View {
    let hospitalName: String
    @StateObject private var viewModel = HospitalBookingViewModel()

    var body: some View {
        Text(/*@START_MENU_TOKEN@*/"Hello, World!"/*@END_MENU_TOKEN@*/)
    }
}

struct HospitalBooking_Previews: PreviewProvider {
    static var previews: some View {
        HospitalBooking(hospitalName: "Hospital1")
    }
}
