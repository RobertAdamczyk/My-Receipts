//
//  PartialSheetView.swift
//  My Receipts (iOS)
//
//  Created by Robert Adamczyk on 10.05.21.
//

import SwiftUI

struct PartialSheetView: View {
    @State var txt = ""
    var body: some View {
        ZStack(alignment: .bottom){
            Color.black.opacity(0.5)
            VStack{
                TextField("", text: $txt)
                    .background(Color.red)
            }
            .frame(maxWidth: .infinity, maxHeight: 200)
            .background(
                Color("Layout")
                    .clipShape(PartialShape(cornerRadius: 30))
                    .overlay(
                        Rectangle()
                            .frame(width: 40, height: 7)
                            .foregroundColor(.gray)
                            .cornerRadius(20)
                            .padding()
                        ,alignment: .top
                    )
            )
        }
        .ignoresSafeArea()
    }
}

struct PartialShape: Shape {
    var cornerRadius: CGFloat
    func path(in rect: CGRect) -> Path {
        return Path { path in
            path.move(to: CGPoint(x: rect.minX, y: rect.maxY))
            path.addArc(center: CGPoint(x: rect.minX + cornerRadius, y: rect.minY + cornerRadius), radius: cornerRadius, startAngle: .init(degrees: 180), endAngle: .init(degrees: 270), clockwise: false)
            
            path.addArc(center: CGPoint(x: rect.maxX - cornerRadius, y: rect.minY + cornerRadius), radius: cornerRadius, startAngle: .init(degrees: -90), endAngle: .zero, clockwise: false)
            path.addLine(to: CGPoint(x: rect.maxX, y: rect.maxY))
        }
    }
}

struct PartialSheetView_Previews: PreviewProvider {
    static var previews: some View {
        PartialSheetView()
    }
}
