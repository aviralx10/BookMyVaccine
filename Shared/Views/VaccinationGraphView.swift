import SwiftUI

struct VaccinationGraphView: View {
    var data: VaccineGraphData?
    
    var body: some View {
        VStack(alignment: .trailing) {
            HStack {
                Spacer()
                VStack(alignment: .trailing) {
                    Text(data?.items.first?.location ?? "Country")
                        .font(.system(.body, design: .rounded))
                    
                    Text("till \(data?.items.first?.dateInstance ?? Date(), style: .date)")
                        .font(.system(.caption, design: .rounded))
                        .foregroundColor(.secondary)
                }
            }
            .padding()
            graphView
        }
        .redacted(reason: data == nil ? .placeholder : [])
    }
    
    var graphView: some View {
        ZStack {
            GridView()
            GraphView(points: data?.peopleVaccinated ?? [])
        }
    }
}

struct GridView: View {
    var body: some View {
        GridShape(spacing: 10)
            .stroke(Color.secondary.opacity(0.5), lineWidth: 0.2)
    }
}

struct GraphView: View {
    var points: [Int]
    var startColor: Color = Color.red.opacity(0.5)
    var endColor: Color = Color(.systemBackground)
    
    var body: some View {
        ZStack {
            LinearGradient(gradient: Gradient(colors: [startColor, endColor]), startPoint: .top, endPoint: .bottom)
                .mask(VaccineGraphShape(points: points, shouldJoint: true))
            VaccineGraphShape(points: points)
                .stroke(Color.red, lineWidth: 2)
        }
    }
}

struct VaccinationGraphView_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            VaccinationGraphView(data: .sample)
            VaccinationGraphView(data: .sample)
                .preferredColorScheme(.dark)
        }
        .previewLayout(.sizeThatFits)
        .frame(width: 300, height: 150)
    }
}
