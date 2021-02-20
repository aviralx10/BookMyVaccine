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
        ZStack(alignment: .trailing) {
            ContainerRelativeShape()
                .fill(Color.secondary.opacity(0.4))
                .cornerRadius(12)
            
            VStack(alignment: .trailing) {
                Text("\(data?.peopleVaccinated ?? "0")")
                    .font(.system(size: 24, weight: .semibold, design: .rounded))
                    .multilineTextAlignment(.trailing)
                
                HStack(spacing: 4) {
                    Text("of")
                        .font(.caption2)
                    Text("\(data?.totalVaccination ?? "0")")
                        .font(.caption2)
                        .foregroundColor(.secondary)
                }
                .foregroundColor(.secondary)
            }
            .padding(.horizontal, 6)
        }
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
