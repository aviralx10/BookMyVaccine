import Foundation

struct VaccineGraphData: Codable {
    var items: [VaccineData]
}

extension VaccineGraphData {
    var peopleVaccinated: [Int] {
        items.compactMap { Int($0.people_vaccinated ?? "") }
    }
}

extension VaccineGraphData {
    static var sample: VaccineGraphData {
        var items = [VaccineData]()
        for _ in 0...15 {
            let item = VaccineData(location: "England", date: "2021-02-19", vaccine: "Pfizer/BioNTech", source_url: URL(string: ""), total_vaccinations: "1171187", people_vaccinated: "\(Int.random(in: 50000...100000))", people_fully_vaccinated: "0")
            items.append(item)
        }
        return VaccineGraphData(items: items)
    }
}
