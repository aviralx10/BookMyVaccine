import Foundation

struct VaccineData: Codable {
    let location: String
    let date: Date
    let vaccine: String
    let source_url: URL?
    let total_vaccinations: Int?
    let people_vaccinated: Int?
    let people_fully_vaccinated: Int?
}

extension VaccineData {
    static var sample1: VaccineData {
        VaccineData(location: "England", date: Date(), vaccine: "Pfizer/BioNTech", source_url: URL(string: "https://coronavirus.data.gov.uk/details/healthcare"), total_vaccinations: 2333764, people_vaccinated: 1959151, people_fully_vaccinated: nil)
    }
    
    static var sample2: VaccineData {
        VaccineData(location: "India", date: Date(), vaccine: "Covaxin, Oxford/AstraZeneca", source_url: URL(string: "https://twitter.com/MoHFW_INDIA/status/1350459098203004927"), total_vaccinations: 0, people_vaccinated: nil, people_fully_vaccinated: nil)
    }
    
    static var sample3: VaccineData {
        VaccineData(location: "India", date: Date(), vaccine: "Covaxin, Oxford/AstraZeneca", source_url: URL(string: "https://www.mohfw.gov.in/"), total_vaccinations: 10188007, people_vaccinated: nil, people_fully_vaccinated: nil)
    }
}
