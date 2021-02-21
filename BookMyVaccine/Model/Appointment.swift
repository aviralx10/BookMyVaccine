import SwiftUI
protocol Appointment {
    var hospitalID: String { get set }
    var time: Date  { get set }
    var patientID: String { get set }
}

protocol QRCodePresentable {
    var qrCode: String { get }
}

struct PendingAppointment: Appointment, Hashable {
    var hospitalID: String
    var time: Date
    var patientID: String

    func hash(into hasher: inout Hasher) {
        hasher.combine("\(hospitalID)\(time)\(patientID)")
    }

    static var initialValue: PendingAppointment {
        .init(
            hospitalID: "",
            time: Date(timeIntervalSince1970: 1613916000),
            patientID: ""
        )
    }
}

extension PendingAppointment: Encodable {
    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(hospitalID, forKey: .hospital)
        try container.encode(time, forKey: .time)
        try container.encode(patientID, forKey: .patient)
    }

    enum CodingKeys: String, CodingKey {
        case hospital, time, patient
    }
}

struct BookedAppointment: Appointment, QRCodePresentable {
    var hospitalID: String
    var time: Date
    var patientID: String
    var qrCode: String
}

extension BookedAppointment: Decodable {

    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.qrCode = try container.decode(String.self, forKey: CodingKeys.id)
        self.time = try container.decode(Date.self, forKey: .time)
        let hospital = try container.nestedContainer(keyedBy: HospitalCodingKeys.self, forKey: .hospital)
        self.hospitalID = try hospital.decode(String.self, forKey: .id)
        let patient = try container.nestedContainer(keyedBy: PatientCodingKeys.self, forKey: .patient)
        self.patientID = try patient.decode(String.self, forKey: .id)
    }

    enum HospitalCodingKeys: String, CodingKey {
        case id
    }
    enum PatientCodingKeys: String, CodingKey {
        case id
    }
    enum CodingKeys: String, CodingKey {
        case id, hospital, time, patient
    }
}
