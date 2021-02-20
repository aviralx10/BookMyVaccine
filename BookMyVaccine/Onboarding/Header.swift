//
//  Header.swift
//  BookMyVaccine
//
//  Created by Aviral Yadav on 21/02/21.
//
import SwiftUI



struct HeaderBar: View {
    var capsuleColor: Color
    var highlightColor: Color
    @Binding var slide: Int
    var total : Int
    var body: some View {
        HStack(spacing: 4) {
            Capsule()
                .foregroundColor((slide == 0) ? highlightColor : capsuleColor)
                .shadow(color: .white, radius: (slide == 0) ? 0.5 :0)
                .frame(width: 40, height: 5)
            Capsule()
                .foregroundColor((slide == 1) ? highlightColor : capsuleColor)
                .shadow(color: .white, radius: (slide == 1) ? 0.5 :0)
                .frame(width: 40, height: 5)
            Capsule()
                .foregroundColor((slide == 2) ? highlightColor : capsuleColor)
                .shadow(color: .white, radius: (slide == 2) ? 0.5 :0)
                .frame(width: 40, height: 5)
            if total > 3 {
                Capsule()
                    .foregroundColor((slide == 3) ? highlightColor : capsuleColor)
                    .shadow(color: .white, radius: (slide == 3) ? 0.5 :0)
                    .frame(width: 40, height: 5)
            }
            if total > 4 {
                Capsule()
                    .foregroundColor((slide == 4) ? highlightColor : capsuleColor)
                    .shadow(color: .white, radius: (slide == 4) ? 0.5 :0)
                    .frame(width: 40, height: 5)
            }
        }.padding(.bottom, 20)
    }
}


