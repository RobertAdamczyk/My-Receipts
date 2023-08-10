//
//  AddCategorieView.swift
//  My Receipts (iOS)
//
//  Created by Robert Adamczyk on 10.05.21.
//

import SwiftUI

struct AddCategorieView: View {

    let completion: (String, String) -> Void

    @State var title: String = ""
    @State var symbol: String = ""

    var body: some View {
        NavigationView{
            Form{
                Section(header: Text("Title")){
                    TextField("Enter...", text: $title)
                        .apply(.regular, size: .M, color: .gray)
                }
                Section(header: Text("Symbol")){
                    TextField("Enter...", text: $symbol)
                        .apply(.regular, size: .M, color: .gray)
                }
                .onChange(of: symbol) { _ in
                    if symbol.count > 2 {
                        symbol = ""
                    }
                    if symbol.count == 2 {
                        symbol.removeLast()
                    }
                }
                
            }
            .navigationTitle("New Categorie")
            .toolbar{
                ToolbarItemGroup(placement: .navigationBarTrailing) {
                    Button(action: {
                        completion(title, symbol)
                    }, label: {
                        Text("Done")
                            .apply(.medium, size: .M, color: .gray)
                    })
                    .disabled(title.count < 3)
                }
            }
        }
        .accentColor(.black)
        .preferredColorScheme(.light)
    }
}
