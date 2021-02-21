//
//  User.swift
//  BookMyVaccine
//
//  Created by Aviral Yadav on 21/02/21.
//

struct User {
    var id: String? = nil
    var name: String
    var appointments: [BookedAppointment]
}

extension User: Decodable {
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.name = try container.decode(String.self, forKey: .name)
        self.id = try container.decode(String.self, forKey: .id)
        self.appointments = []
    }
}

extension User: Encodable {
    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(name, forKey: .name)
        try container.encode([String](), forKey: .appointments)
    }

    enum CodingKeys: String, CodingKey {
        case name, id, appointments
    }
}
