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
    @AppStorage("userID") var patientID: String = ""
    @Published var bookedAppointments = [BookedAppointment]()
    @Published var selectedDate = Date()
    @Published var selectedAppointment: PendingAppointment = .initialValue
    @Published var bookedAppointment: BookedAppointment?
    var hospital: Hospital?

    func fetchAppointments(for hospital: Hospital) {
        let baseURL = URL(string: "https://bookmyvaccine.herokuapp.com/hospitals/appointments")!
        var urlComponents = URLComponents(url: baseURL, resolvingAgainstBaseURL: false)!
        urlComponents.queryItems = [
            URLQueryItem(name: "hospitalName", value: hospital.name)
        ]
        let url = urlComponents.url!
        NetworkManager().fetch(
            [BookedAppointment].self,
            from: url
        )
        .flatMap { (appointments: [BookedAppointment]) -> AnyPublisher<[BookedAppointment], Error> in
            if appointments.isEmpty {
                return self.createHospital(with: hospital)
                    .flatMap { (hospital: Hospital) -> AnyPublisher<[BookedAppointment], Error> in
                        self.hospital = hospital
                        return Just(appointments)
                            .setFailureType(to: Error.self)
                            .eraseToAnyPublisher()
                    }
                    .eraseToAnyPublisher()
            } else {
                let booked = appointments[0]
                DispatchQueue.main.async {
                    self.hospital?.id = booked.hospitalID
                }
                return Just(appointments)
                    .setFailureType(to: Error.self)
                    .eraseToAnyPublisher()
            }
        }
        .replaceError(with: [])
        .receive(on: RunLoop.main)
        .assign(to: \.bookedAppointments, on: self)
        .store(in: &subscribers)
    }

    func createHospital(with hospital: Hospital) -> AnyPublisher<Hospital, Error> {
        let url = URL(string: "https://bookmyvaccine.herokuapp.com/hospitals")!
        return NetworkManager().create(hospital, on: url)
    }

    func bookAppointment() {
        let url = URL(string: "https://bookmyvaccine.herokuapp.com/appointments")!
        return NetworkManager().create(selectedAppointment, responseType: BookedAppointment.self, on: url)
            .receive(on: RunLoop.main)
            .sink(receiveCompletion: { completion in
                if case .failure(let error) = completion {
                    print(error.localizedDescription)
                }
            }, receiveValue: {
                self.bookedAppointment = $0
            })
            .store(in: &subscribers)
    }

    var availableAppointments: [PendingAppointment] {
        guard let hospitalID = self.hospital?.id else { return [] }
        let booked = bookedAppointments.map(\.time)
        var available = [PendingAppointment]()
        for hour in 9...12 {
            for min in stride(from: 0, through: 45, by: 15) {
                let calendar = Calendar.current
                var selectedDate = self.selectedDate
                selectedDate = calendar.date(bySetting: .hour, value: hour, of: selectedDate)!
                selectedDate = calendar.date(bySetting: .minute, value: min, of: selectedDate)!
                if !booked.contains(selectedDate) {
                    available.append(
                        PendingAppointment(hospitalID: hospitalID, time: selectedDate, patientID: patientID)
                    )
                }
            }
        }
        return available
    }

    func formattedTime(for appointment: Appointment) -> String {
        Date.timeFormatter.string(from: appointment.time)
    }

    func formattedDate(for appointment: Appointment) -> String {
        Date.dateOnlyFormatter.string(from: appointment.time)
    }

    var timeText: String {
        formattedTime(for: selectedAppointment)
    }
}

struct HospitalBooking: View {
    let hospital: Hospital
    @StateObject private var viewModel = HospitalBookingViewModel()
    @State private var isFetching = false

    var body: some View {
        Form {
            Section(header: Text("Selected Hospital")) {
                Text(hospital.name)
            }
            Section(header: Text("Date")) {
                DatePicker(
                    "Date",
                    selection: $viewModel.selectedDate,
                    in: Date()...,
                    displayedComponents: [.date]
                )
            }
            Section(header: Text("Time")) {
                Picker(
                    "Time", selection: $viewModel.selectedAppointment
                ) {
                    ForEach(viewModel.availableAppointments, id: \.time) { appointment in
                        Text(viewModel.formattedTime(for: appointment))
                            .tag(appointment)
                    }
                }
            }
        }
        .toolbar {
            ToolbarItem(placement: .confirmationAction) {
                NavigationLink("Book", destination:
                    ConfirmationPage(viewModel: viewModel)
                )
                .disabled(viewModel.selectedAppointment == .initialValue)
            }
        }
        .onAppear(perform: handleOnAppear)
    }


    func handleOnAppear() {
        if !isFetching {
            viewModel.fetchAppointments(for: hospital)
        }
        isFetching = true
    }
}

struct ConfirmationPage: View {
    @ObservedObject var viewModel: HospitalBookingViewModel

    var body: some View {
        if let bookedAppointment = viewModel.bookedAppointment {
            VStack {
                Text("Confirmed")
                Section(header: Text("Hospital Name")) {
                    Text(viewModel.hospital!.name)
                }
                Section(header: Text("Date")) {
                    Text(viewModel.formattedDate(for: bookedAppointment))
                }
                Section(header: Text("Time")) {
                    Text(viewModel.formattedTime(for: bookedAppointment))
                }
                //TODO: QR Code for bookedAppointment.id
            }
        } else {
            ProgressView()
                .onAppear(perform: viewModel.bookAppointment)
        }
    }
}

struct HospitalBooking_Previews: PreviewProvider {
    static var previews: some View {
        HospitalBooking(hospital: .init(name: "Hospital", latitude: 0, longitude: 0))
    }
}
