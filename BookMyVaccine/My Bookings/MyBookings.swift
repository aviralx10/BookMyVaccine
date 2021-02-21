//
//  MyBookings.swift
//  BookMyVaccine
//
//  Created by Aviral Yadav on 20/02/21.
//

import Combine
import SwiftUI
import CoreImage.CIFilterBuiltins

struct MyBookings: View {
    @AppStorage("userID") var userID: String = ""
    @StateObject private var viewModel = MyBookingsViewModel()

    let context = CIContext()
    let filter = CIFilter.qrCodeGenerator()
    var body: some View {
        ScrollView {
            ForEach(viewModel.bookings) { booking in
                VStack{
                    Text("MY BOOKINGS")
                        .fontWeight(.heavy)
                        .padding(20)
                        .font(/*@START_MENU_TOKEN@*/.title/*@END_MENU_TOKEN@*/)
                    VStack{
                        Text("MY VENUE/HOSPITAL NAME")
                            .fontWeight(.heavy)
                            .frame(width: 210, height: 30, alignment: .center)
                            .foregroundColor(.white)
                            .padding(.all)
                            .background(Color.blue)
                            .cornerRadius(16)
                        Text(booking.hospitalName)
                            .fontWeight(.bold)
                            .padding(10)
                    }.padding(20)
                    VStack{
                        Text("MY TIME SLOT")
                            .fontWeight(.heavy)
                            .frame(width: 210, height: 30, alignment: .center)
                            .foregroundColor(.white)
                            .padding(.all)
                            .background(Color.blue)
                            .cornerRadius(16)
                        Text(Date.timeFormatter.string(from: booking.time))
                            .fontWeight(.bold)
                            .padding(10)
                        Text(Date.dateOnlyFormatter.string(from: booking.time))
                            .fontWeight(.bold)
                            .padding(10)
                    }.padding(20)

                    Text("CONTACTLESS QR CODE")
                        .fontWeight(.heavy)
                        .frame(width: 210, height: 30, alignment: .center)
                    .foregroundColor(.white)
                    .padding(.all)
                    .background(Color.blue)
                    .cornerRadius(16)
                    Image(uiImage: generateQRCode(from: booking.qrCode))
                        .interpolation(.none)
                        .resizable()
                        .scaledToFit()
                        .frame(width:200,height:200)
                    Spacer()

                }
            }
        }
    }

    func generateQRCode(from string: String)->UIImage{
        let data = Data(string.utf8)
            filter.setValue(data, forKey: "inputMessage")

            if let outputImage = filter.outputImage {
                if let cgimg = context.createCGImage(outputImage, from: outputImage.extent) {
                    return UIImage(cgImage: cgimg)
                }
            }

            return UIImage(systemName: "xmark.circle") ?? UIImage()
    }
}

struct Booking: Identifiable {
    let hospitalName: String
    let qrCode: String
    let time: Date

    init(bookedAppointment: BookedAppointment, hospital: Hospital) {
        self.hospitalName = hospital.name
        self.qrCode = bookedAppointment.qrCode
        self.time = bookedAppointment.time
    }

    var id: String {
        qrCode
    }
}

final class MyBookingsViewModel: ObservableObject {
    var subscribers = Set<AnyCancellable>()
    @Published var bookedAppointments = [BookedAppointment]()
    @Published var hospitals: [Hospital] = []
    var bookings: [Booking] {
        bookedAppointments.compactMap { appointment in
            let hospital = hospitals.first { $0.id == appointment.hospitalID }
            if let hospital = hospital {
                return Booking(bookedAppointment: appointment, hospital: hospital)
            } else {
                return nil
            }
        }
    }

    func findAppointments(forUser userID: String) {
        let url = URL(string: "https://bookmyvaccine.herokuapp.com/patients/\(userID)/appointments")!
        NetworkManager().fetch([BookedAppointment].self, from: url)
            .replaceError(with: [])
            .sink(receiveValue: { [self] in
                self.bookedAppointments = $0
                let arrayOfPublishers = $0.map { (appointment: BookedAppointment) -> AnyPublisher<Hospital, Error> in
                    let url = URL(string: "https://bookmyvaccine.herokuapp.com/hospitals/\(appointment.hospitalID)")!
                    return NetworkManager().fetch(Hospital.self, from: url)
                }
                Publishers.MergeMany(arrayOfPublishers)
                    .collect()
                    .replaceError(with: [])
                    .assign(to: \.hospitals, on: self)
                    .store(in: &subscribers)
            })
            .store(in: &subscribers)
    }
}
