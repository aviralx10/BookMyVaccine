//
//  String+Extensions.swift
//  BookMyVaccine
//
//  Created by Neil Jain on 2/20/21.
//

import Foundation

extension String {
    var optionalString: String? {
        let isEmpty = self.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty
        return isEmpty ? nil : self
    }
}
