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
                .opacity(animation ? 0.2 : 0)
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
                    .background(CustomRectangle(radius: 20)
                                    .foregroundColor(Color("Layout")))
                Rectangle()
                    .frame(height: 0.8)
                    .foregroundColor(.secondary)
                List{
                    ForEach(SortBy.allCases, id: \.self) { item in
                        Text("\(item.info.name)")
                            .padding(.vertical, 10)
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
        }
        .ignoresSafeArea()
        .onAppear(){
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.15) {
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
