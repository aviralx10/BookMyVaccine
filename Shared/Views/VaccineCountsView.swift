//
//  VaccineCountsView.swift
//  BookMyVaccine
//
//  Created by Neil Jain on 2/20/21.
//

import SwiftUI

struct VaccineCountsView: View {
    var count: String
    var total: String
    
    var body: some View {
        ZStack(alignment: .trailing) {
            ContainerRelativeShape()
                .fill(Color.secondary.opacity(0.4))
                .cornerRadius(12)
            
            VStack(alignment: .trailing) {
                Text(count)
                    .font(.system(size: 24, weight: .semibold, design: .rounded))
                    .multilineTextAlignment(.trailing)
                
                HStack(spacing: 4) {
                    Text("of")
                        .font(.caption2)
                    Text(total)
                        .font(.caption2)
                        .foregroundColor(.secondary)
                }
                .foregroundColor(.secondary)
            }
            .padding(6)
        }
    }
}

struct VaccineCountsView_Previews: PreviewProvider {
    static var previews: some View {
        VaccineCountsView(count: "100", total: "160")
            .previewLayout(.sizeThatFits)
    }
}
