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
        VStack(alignment: .leading, spacing: 8){
            Image(systemName: "folder.fill")
                .resizable()
                .frame(width: 40, height: 40)
                .foregroundColor(color)
                .padding(.bottom, 10)
                .padding(.leading, 10)
            Text("Moje urządzenia")
                .bold()
                .lineLimit(1)
            Text("23 receipts")
                .font(.subheadline)
                .foregroundColor(.secondary)
        }
        .frame(width: 150, height: 150)
        .background(RoundedRectangle(cornerRadius: 25)
                        .foregroundColor(.white)
                        .shadow(radius: 5))
        .overlay(Image(systemName: "ellipsis")
                    .font(.title2)
                    .rotationEffect(.init(degrees: 90))
                    .foregroundColor(.secondary)
                    .padding(.top, 25)
                    .padding(.trailing, 5), alignment: .topTrailing)
    }
}

struct CategorieView_Previews: PreviewProvider {
    static var previews: some View {
        CategorieView(color: .red)
    }
}
