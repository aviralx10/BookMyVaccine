//
//  VaccineGraphWidget.swift
//  BookMyVaccine
//
//  Created by Neil Jain on 2/20/21.
//

import WidgetKit
import SwiftUI

struct VaccineGraphProvider: TimelineProvider {
    func placeholder(in context: Context) -> VaccineGraphEntry {
        VaccineGraphEntry(date: Date(), data: nil)
    }
    
    func getSnapshot(in context: Context, completion: @escaping (VaccineGraphEntry) -> Void) {
        fetchAllData { (data) in
            let entry = VaccineGraphEntry(date: Date(), data: .init(items: data))
            completion(entry)
        }
    }
    
    func getTimeline(in context: Context, completion: @escaping (Timeline<VaccineGraphEntry>) -> Void) {
        fetchAllData { (vaccineData) in
            var entries: [VaccineGraphEntry] = []
            let currentDate = Date()
            let entryDate = Calendar.current.date(byAdding: .hour, value: 12, to: currentDate)!
            let entry = VaccineGraphEntry(date: entryDate, data: .init(items: vaccineData))
            entries.append(entry)
            
            let timeline = Timeline(entries: entries, policy: .atEnd)
            completion(timeline)
        }
    }
    
    private func fetchAllData(completion: @escaping ([VaccineData])->Void) {
        let url = URL(string: "https://swiftuijam.herokuapp.com/allData/England")!
        NetworkManager().fetch([VaccineData].self, from: url) { (result) in
            switch result {
            case .success(let data):
                completion(data)
            case .failure(let error):
                print(error)
                completion([])
            }
        }
    }
}

struct VaccineGraphEntry: TimelineEntry {
    let date: Date
    let data: VaccineGraphData?
}

struct VaccineGraphEntryView: View {
    var entry: VaccineGraphProvider.Entry
    var body: some View {
        VaccinationGraphView(data: entry.data)
    }
}

struct VaccineGraphWidget: Widget {
    let kind: String = "VaccineGraphWidget"
    
    var body: some WidgetConfiguration {
        StaticConfiguration(kind: kind, provider: VaccineGraphProvider()) { entry in
            VaccineGraphEntryView(entry: entry)
        }
        .configurationDisplayName("Vaccinations Graph")
        .description("Displays the graph of vaccinations for the country")
        .supportedFamilies([.systemMedium])
    }
}

struct VaccineGraphWidget_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            VaccineGraphEntryView(entry: VaccineGraphEntry(date: Date(), data: .sample))
                .previewContext(WidgetPreviewContext(family: .systemMedium))
            
            VaccineGraphEntryView(entry: VaccineGraphEntry(date: Date(), data: nil))
                .preferredColorScheme(.dark)
                .previewContext(WidgetPreviewContext(family: .systemMedium))
        }
    }
}
