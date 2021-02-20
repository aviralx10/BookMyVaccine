//
//  BookMyVaccineWidgetBundle.swift
//  VaccineInfoWidgetExtension
//
//  Created by Neil Jain on 2/20/21.
//

import WidgetKit
import SwiftUI

@main
struct BookMyVaccineWidgetBundle: WidgetBundle {
    var body: some Widget {
        VaccineInfoWidget()
        VaccineGraphWidget()
    }
}
