//
//  VaccineInfoWidget.swift
//  VaccineInfoWidget
//
//  Created by Neil Jain on 2/20/21.
//

import WidgetKit
import SwiftUI
import Combine

struct VaccinationCountProvider: IntentTimelineProvider {
    typealias Entry = VaccineDataEntry
    typealias Intent = ContryPickerIntent
    
    func placeholder(in context: Context) -> VaccineDataEntry {
        VaccineDataEntry(date: Date(), data: nil)
    }

    func getSnapshot(for configuration: ContryPickerIntent, in context: Context, completion: @escaping (VaccineDataEntry) -> Void) {
        let country = VaccineCountry(rawValue: configuration.country.rawValue) ?? .UnitedStates
        fetchVaccineData(country: country) { (data) in
            let entry = VaccineDataEntry(date: Date(), data: data)
            completion(entry)
        }
    }
    
    func getTimeline(for configuration: ContryPickerIntent, in context: Context, completion: @escaping (Timeline<VaccineDataEntry>) -> Void) {
        let country = VaccineCountry(rawValue: configuration.country.rawValue) ?? .UnitedStates
        fetchVaccineData(country: country) { (data) in
            var entries: [VaccineDataEntry] = []
            let currentDate = Date()
            let entryDate = Calendar.current.date(byAdding: .hour, value: 12, to: currentDate)!
            let entry = VaccineDataEntry(date: entryDate, data: data)
            entries.append(entry)

            let timeline = Timeline(entries: entries, policy: .atEnd)
            completion(timeline)
        }
    }
    
    private func fetchVaccineData(country: VaccineCountry, completion: @escaping (VaccineData?)->Void) {
        let url = URL(string: "https://swiftuijam.herokuapp.com/newestData/\(country.searchKey)")!
        NetworkManager().fetch(VaccineData.self, from: url) { (result) in
            switch result {
            case .success(let data):
                completion(data)
            case .failure:
                completion(nil)
            }
        }
    }
}

struct VaccineDataEntry: TimelineEntry {
    let date: Date
    let data: VaccineData?
}

struct VaccineInfoWidgetEntryView : View {
    var entry: VaccinationCountProvider.Entry

    var body: some View {
        VaccineInfoView(data: entry.data)
    }
}

struct VaccineInfoWidget: Widget {
    let kind: String = "VaccineInfoWidget"
    
    var body: some WidgetConfiguration {
        IntentConfiguration(kind: kind, intent: ContryPickerIntent.self, provider: VaccinationCountProvider()) { (entry) in
            VaccineInfoWidgetEntryView(entry: entry)
        }
        .configurationDisplayName("Daily Vaccination Count")
        .description("Displays the daily vaccinations count for the country.")
        .supportedFamilies([.systemSmall])
    }
}

struct VaccineInfoWidget_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            VaccineInfoWidgetEntryView(entry: VaccineDataEntry(date: Date(), data: .sample1))
                .previewContext(WidgetPreviewContext(family: .systemSmall))
            
            VaccineInfoWidgetEntryView(entry: VaccineDataEntry(date: Date(), data: nil))
                .preferredColorScheme(.dark)
                .previewContext(WidgetPreviewContext(family: .systemSmall))
        }
    }
}
