//
//  VaccineInfoWidget.swift
//  VaccineInfoWidget
//
//  Created by Neil Jain on 2/20/21.
//

import WidgetKit
import SwiftUI

struct VaccinationCountProvider: TimelineProvider {
    func placeholder(in context: Context) -> VaccineDataEntry {
        VaccineDataEntry(date: Date(), data: nil)
    }

    func getSnapshot(in context: Context, completion: @escaping (VaccineDataEntry) -> ()) {
        let entry = VaccineDataEntry(date: Date(), data: nil)
        completion(entry)
    }

    func getTimeline(in context: Context, completion: @escaping (Timeline<Entry>) -> ()) {
        var entries: [VaccineDataEntry] = []

        // Generate a timeline consisting of five entries an hour apart, starting from the current date.
        let currentDate = Date()
        let entryDate = Calendar.current.date(byAdding: .hour, value: 12, to: currentDate)!
        let entry = VaccineDataEntry(date: entryDate, data: .sample1)
        entries.append(entry)

        let timeline = Timeline(entries: entries, policy: .atEnd)
        completion(timeline)
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
        StaticConfiguration(kind: kind, provider: VaccinationCountProvider()) { entry in
            VaccineInfoWidgetEntryView(entry: entry)
        }
        .configurationDisplayName("Daily Vaccinations")
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
