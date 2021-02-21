//
//  Date+Extension.swift
//  BookMyVaccine
//
//  Created by Neil Jain on 2/20/21.
//

import Foundation

extension Date {
    static var formatter: DateFormatter {
        DateFormatter()
    }

    static var timeFormatter: DateFormatter {
        let formatter = DateFormatter()
        formatter.dateStyle = .none
        formatter.timeStyle = .medium
        return formatter
    }

    static var dateOnlyFormatter: DateFormatter {
        let formatter = DateFormatter()
        formatter.dateStyle = .medium
        formatter.timeStyle = .none
        return formatter
    }
}
