//
//  CategorieView.swift
//  My Receipts (iOS)
//
//  Created by Robert Adamczyk on 25.05.21.
//

import SwiftUI

struct CategorieView: View {
    var color: Color
    var body: some View {
        VStack(alignment: .leading, spacing: 5){
            Image(systemName: "folder.fill")
                .resizable()
                .frame(width: 42, height: 42)
                .foregroundColor(color)
            Text("Devices")
                .fontWeight(.bold)
                .font(.custom("Roboto Medium", size: 14))
                .lineLimit(1)
            Text("7 receipts")
                .font(.custom("Roboto Medium", size: 10))
                .foregroundColor(Color(#colorLiteral(red: 0.44, green: 0.44, blue: 0.44, alpha: 1)))
                .lineLimit(1)
        }
        .padding(.leading, 15)
        .frame(width: 100, height: 100, alignment: .leading)
        .background(
            RoundedRectangle(cornerRadius: 13)
                .fill(Color(#colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)))
                .frame(width: 100, height: 100)
                .shadow(color: Color(#colorLiteral(red: 0, green: 0, blue: 0, alpha: 0.2)), radius:8, x:0, y:0)
        )
        .overlay(Image(systemName: "ellipsis")
                    .font(.title2)
                    .rotationEffect(.init(degrees: 90))
                    .foregroundColor(.secondary)
                    .padding(.top, 20)
                    .padding(.trailing, 5), alignment: .topTrailing)
    }
}

struct CategorieView_Previews: PreviewProvider {
    static var previews: some View {
        CategorieView(color: .red)
    }
}
