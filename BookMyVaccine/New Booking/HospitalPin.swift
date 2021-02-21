//
//  HospitalPin.swift
//  BookMyVaccine
//
//  Created by Kevin Peng on 2021-02-20.
//

import SwiftUI

struct HospitalPin: View {
    let hospitalName: String
    let highlighted: Bool
    var body: some View {
        ZStack {
            Circle()
                .foregroundColor(highlighted ? Color.red : Color.green)
            Image(systemName: "cross.fill")
                .foregroundColor(.white)
        }
        .frame(width: 30, height: 30, alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/)
    }
}

struct HospitalPin_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            HospitalPin(hospitalName: "Central Hospital", highlighted: true)
            HospitalPin(hospitalName: "Central Hospital", highlighted: false)
        }
        .previewLayout(.sizeThatFits)
    }
}
