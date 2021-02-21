import Foundation

struct Hospital: Codable, Identifiable {
    let name: String
    let latitude: Double
    let longitude: Double
    var id: String? = UUID().uuidString

    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(name, forKey: .name)
        try container.encode(latitude, forKey: .latitude)
        try container.encode(longitude, forKey: .longitude)
    }

    enum CodingKeys: String, CodingKey {
        case name, latitude, longitude
    }
}

