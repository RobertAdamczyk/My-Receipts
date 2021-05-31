//
//  SortByView.swift
//  My Receipts (iOS)
//
//  Created by Robert Adamczyk on 14.05.21.
//

import SwiftUI

struct SortByView: View {
    @Binding var showSort: Bool
    @Binding var sortBy: SortBy
    
    @State var animation = false
    var body: some View {
        ZStack(alignment: .bottom){
            Color.black
                .opacity(animation ? 0.05 : 0)
                .onTapGesture {
                    animation = false
                    withAnimation{
                        showSort.toggle()
                    }
                }
            
            VStack(spacing: -0.5){
                Text("Sort by:")
                    .font(.title3)
                    .fontWeight(.semibold)
                    .frame(maxWidth: .infinity)
                    .padding()
                Rectangle()
                    .frame(height: 0.8)
                    .foregroundColor(.secondary)
                ScrollView{
                    ForEach(SortBy.allCases, id: \.self) { item in
                        Text("\(item.info.name)")
                            .frame(maxWidth: .infinity, alignment: .leading)
                            .padding(.vertical, 10)
                            .padding(.horizontal)
                            .contentShape(Rectangle())
                            .onTapGesture {
                                animation = false
                                sortBy = item
                                withAnimation{
                                    showSort.toggle()
                                }
                            }
                    }
                }
            }
            .frame(height: 350)
            .background(CustomRectangle(radius: 14)
                            .fill(LinearGradient(
                                    gradient: Gradient(stops: [
                                                        .init(color: Color(#colorLiteral(red: 0.5843137502670288, green: 0.8823529481887817, blue: 0.8274509906768799, alpha: 1)), location: 0),
                                                        .init(color: Color(#colorLiteral(red: 0.9882352948188782, green: 0.8901960253715515, blue: 0.5411764979362488, alpha: 1)), location: 1)]),
                                    startPoint: UnitPoint(x: 0.22533334834366808, y: 0.20467034102585646),
                                    endPoint: UnitPoint(x: 1.05466673063715, y: 1.1854396050452791))))
        }
        .ignoresSafeArea()
        .onAppear(){
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.2) {
                withAnimation{
                    animation = true
                }
            }
        }
    }
    
    
}

struct SortByView_Previews: PreviewProvider {
    static var previews: some View {
        SortByView(showSort: .constant(true), sortBy: .constant(SortBy.purchaseAscending))
    }
}

struct CustomRectangle: Shape {
    var radius: CGFloat
    func path(in rect: CGRect) -> Path {
        return Path { path in
            path.move(to: CGPoint(x: rect.minX, y: rect.maxY))
            path.addLine(to: CGPoint(x: rect.minX, y: rect.minY + radius))
            path.addArc(center: CGPoint(x: rect.minX + radius, y: rect.minY + radius), radius: radius, startAngle: .init(degrees: 180), endAngle: .init(degrees: 270), clockwise: false)
            path.addLine(to: CGPoint(x: rect.maxX - radius/2, y: rect.minY))
            path.addArc(center: CGPoint(x: rect.maxX - radius, y: rect.minY + radius), radius: radius, startAngle: .init(degrees: 270), endAngle: .init(degrees: 360), clockwise: false)
            path.addLine(to: CGPoint(x: rect.maxX, y: rect.maxY))
        }
    }
    
    
}
