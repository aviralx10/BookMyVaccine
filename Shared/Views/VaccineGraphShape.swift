//
//  VaccineGraphShape.swift
//  VaccineInfoWidgetExtension
//
//  Created by Neil Jain on 2/20/21.
//

import SwiftUI

struct VaccineGraphShape: Shape {
    var points: [Int]
    var shouldJoint: Bool = false
    
    var max: Double {
        Double(points.max() ?? 1)
    }
    
    var normalisedPoints: [Double] {
        points.map({Double($0)/max})
    }
    
    func path(in rect: CGRect) -> Path {
        var path = Path()
        path.move(to: CGPoint(x: 0, y: rect.height))
        if normalisedPoints.count > 0 {
            for index in 0..<normalisedPoints.count {
                path.addLine(to: position(of: normalisedPoints[index], at: index, in: rect))
            }
            if shouldJoint {
                path.addLine(to: CGPoint(x: rect.width, y: rect.height))
            }
        }
        return path
    }
    
    private func position(of point: Double, at index: Int, in rect: CGRect) -> CGPoint {
        print(points)
        let space = rect.width / CGFloat(normalisedPoints.count)
        let x = space * CGFloat(index)
        let y = rect.height - (rect.height * CGFloat(point))
        return CGPoint(x: x, y: y)
    }
}

struct VaccineGraphShape_Previews: PreviewProvider {
    static var previews: some View {
        VaccineGraphShape(points: VaccineGraphData.sample.peopleVaccinated)
    }
}
