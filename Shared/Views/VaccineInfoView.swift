import SwiftUI

struct VaccineInfoView: View {
    var data: VaccineData?
    
    var body: some View {
        VStack(alignment: .trailing) {
            titleView
            countryAndDateView
            countsView
        }
        .padding()
        .redacted(reason: (data == nil) ? .placeholder  : [])
    }
    
    var titleView: some View {
        Text("Vaccinations")
            .foregroundColor(.red)
            .font(.system(.caption, design: .rounded))
            .bold()
    }
    
    var countryAndDateView: some View {
        VStack(alignment: .trailing) {
            Text("\(data?.location ?? "Country")")
                .font(.system(.title3, design: .rounded))
            
            Text(data?.dateInstance ?? Date(), style: .date)
                .font(.system(size: 13, weight: .regular, design: .rounded))
                .foregroundColor(.secondary)
        }
    }
    
    var countsView: some View {
        VaccineCountsView(
            count: "\(data?.peopleVaccinated ?? "0")",
            total: "\(data?.totalVaccination ?? "0")"
        )
    }
}

struct VaccineInfoView_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            VaccineInfoView(data: nil)
                .previewLayout(PreviewLayout.sizeThatFits)
            
            VaccineInfoView(data: .sample1)
                .previewLayout(PreviewLayout.sizeThatFits)
                .preferredColorScheme(.dark)
        }
        .frame(width: 150, height: 150)
    }
}
