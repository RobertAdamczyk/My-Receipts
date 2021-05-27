//
//  CategorieView.swift
//  My Receipts (iOS)
//
//  Created by Robert Adamczyk on 25.05.21.
//

import SwiftUI

struct CategorieView: View {
    var categorie: Categorie?
    var count: Int?
    @EnvironmentObject var coreData: CoreDataViewModel
    @State var title = "Categorie"
    @State var symbol = "C"
    @State var receipts = 0
    var body: some View {
        VStack(alignment: .leading, spacing: 5){
            Text(categorie != nil ? symbol : "A")
                .font(.largeTitle)
                .fontWeight(.black)
            Text(categorie != nil ? title : "All")
                .fontWeight(.bold)
                .font(.custom("Roboto Medium", size: 14))
                .lineLimit(1)
            Text("\(count == nil ? receipts : count!) receipts")
                .font(.custom("Roboto Medium", size: 10))
                .foregroundColor(Color(#colorLiteral(red: 0.44, green: 0.44, blue: 0.44, alpha: 1)))
                .lineLimit(1)
        }
        .padding(.leading, 15)
        .frame(width: 100, height: 100, alignment: .leading)
        .background(
            RoundedRectangle(cornerRadius: 13)
                .fill(coreData.selectedCategorie == categorie ?
                        LinearGradient(gradient: Gradient(stops: [
                        .init(color: Color(#colorLiteral(red: 0.5843137502670288, green: 0.8823529481887817, blue: 0.8274509906768799, alpha: 1)), location: 0),
                        .init(color: Color(#colorLiteral(red: 0.9882352948188782, green: 0.8901960253715515, blue: 0.5411764979362488, alpha: 1)), location: 1)]),
                            startPoint: UnitPoint(x: 0.49999995812773845, y: 1.4901160139135783e-8),
                            endPoint: UnitPoint(x: 0.9999999232795123, y: 1.4049999650314455)) :
                        LinearGradient(gradient: Gradient(colors: [.white, .white]), startPoint: .top, endPoint: .bottom))
                .frame(width: 100, height: 100)
                .shadow(color: Color("ShadowColor"), radius:8, x:0, y:0)
        )
        .overlay(Image(systemName: "ellipsis")
                    .font(.title2)
                    .rotationEffect(.init(degrees: 90))
                    .foregroundColor(.secondary)
                    .padding(.top, 20)
                    .padding(.trailing, 5), alignment: .topTrailing)
        .onAppear(){
            if let unwrappedTitle = categorie?.title {
                title = unwrappedTitle
            }
            if let unwrappedSymbol = categorie?.symbol {
                symbol = unwrappedSymbol
            }
            if let unwrappedCount = categorie?.receipts?.count {
                receipts = unwrappedCount
            }
            
        }
    }
}
