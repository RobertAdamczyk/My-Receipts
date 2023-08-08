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
                }
                Section(header: Text("Symbol")){
                    TextField("Enter...", text: $symbol)
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
                    Button("Done") {
                        completion(title, symbol)
                    }
                    .disabled(title.count < 3)
                }
            }
        }
        .accentColor(.black)
        .preferredColorScheme(.light)
    }
}
