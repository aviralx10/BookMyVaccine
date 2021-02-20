//
//  GridShape.swift
//  BookMyVaccine
//
//  Created by Neil Jain on 2/20/21.
//

import SwiftUI

struct GridShape: Shape {
    var spacing: CGFloat = 10
    func path(in rect: CGRect) -> Path {
        let hlineCount = Int(rect.width / spacing)
        let vlineCount = Int(rect.height / spacing)
        var path = Path()
        for i in 0..<hlineCount {
            path.move(to: CGPoint(x: CGFloat(i) * spacing, y: 0))
            path.addLine(to: CGPoint(x: CGFloat(i) * spacing, y: rect.height))
        }
        for i in 0..<vlineCount {
            path.move(to: CGPoint(x: 0, y: CGFloat(i) * spacing))
            path.addLine(to: CGPoint(x: rect.width, y: CGFloat(i) * spacing))
        }
        return path
    }
}

struct GridShape_Previews: PreviewProvider {
    static var previews: some View {
        GridShape()
            .stroke(Color.secondary, lineWidth: 0.2)
            .frame(width: 300, height: 150)
            .previewLayout(.sizeThatFits)
    }
}
