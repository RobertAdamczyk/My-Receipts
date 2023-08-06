//
//  SortByView.swift
//  My Receipts (iOS)
//
//  Created by Robert Adamczyk on 14.05.21.
//

import SwiftUI

struct SortByView: View {

    let completion: (SortBy) -> Void

    var body: some View {
        ZStack(alignment: .bottom){
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
                    VStack(spacing: 8) {
                        ForEach(SortBy.allCases, id: \.self) { item in
                            Text("\(item.info.name)")
                                .frame(maxWidth: .infinity, alignment: .leading)
                                .padding(.vertical, 10)
                                .padding(.horizontal)
                                .contentShape(Rectangle())
                                .onTapGesture {
                                    completion(item)
                                }
                        }
                    }
                }
            }
            .background(LinearGradient(
                gradient: Gradient(stops: [
                                    .init(color: Color(#colorLiteral(red: 0.5843137502670288, green: 0.8823529481887817, blue: 0.8274509906768799, alpha: 1)), location: 0),
                                    .init(color: Color(#colorLiteral(red: 0.9882352948188782, green: 0.8901960253715515, blue: 0.5411764979362488, alpha: 1)), location: 1)]),
                startPoint: UnitPoint(x: 0.22533334834366808, y: 0.20467034102585646),
                endPoint: UnitPoint(x: 1.05466673063715, y: 1.1854396050452791)))
        }
    }
    
    
}

struct SortByView_Previews: PreviewProvider {
    static var previews: some View {
        SortByView { item in
            print("\(item)")
        }
    }
}
