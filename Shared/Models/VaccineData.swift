import Foundation

struct VaccineData: Codable {
    let location: String
    let date: String
    let vaccine: String
    let source_url: URL?
    let total_vaccinations: String?
    let people_vaccinated: String?
    let people_fully_vaccinated: String?
}

extension VaccineData {
    var dateInstance: Date? {
        let formatter = Date.formatter
        formatter.dateFormat = "yyyy-MM-dd"
        return formatter.date(from: date)
    }
    
    var totalVaccination: String? {
        total_vaccinations?.optionalString
    }
    
    var peopleVaccinated: String? {
        people_vaccinated?.optionalString
    }
    
    var peopleFullyVaccinated: String? {
        people_fully_vaccinated?.optionalString
    }
}

extension VaccineData {
    static var sample1: VaccineData {
        VaccineData(location: "England", date: "2021-02-19", vaccine: "Pfizer/BioNTech", source_url: URL(string: "https://coronavirus.data.gov.uk/details/healthcare"), total_vaccinations: "2333764", people_vaccinated: "1959151", people_fully_vaccinated: nil)
    }
    
    static var sample2: VaccineData {
        VaccineData(location: "India", date: "2021-02-19", vaccine: "Covaxin, Oxford/AstraZeneca", source_url: URL(string: "https://twitter.com/MoHFW_INDIA/status/1350459098203004927"), total_vaccinations: "0", people_vaccinated: nil, people_fully_vaccinated: nil)
    }
    
    static var sample3: VaccineData {
        VaccineData(location: "India", date: "2021-02-19", vaccine: "Covaxin, Oxford/AstraZeneca", source_url: URL(string: "https://www.mohfw.gov.in/"), total_vaccinations: "10188007", people_vaccinated: nil, people_fully_vaccinated: nil)
    }
}
