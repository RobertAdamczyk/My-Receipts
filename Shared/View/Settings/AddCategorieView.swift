//
//  AddCategorieView.swift
//  My Receipts (iOS)
//
//  Created by Robert Adamczyk on 10.05.21.
//

import SwiftUI

struct AddCategorieView: View {
    @Binding var showSheet: Bool
    @State var txt: String = ""
    @State var symbol: String = ""
    @EnvironmentObject var coreDataViewModel: CoreDataViewModel
    var body: some View {
        NavigationView{
            Form{
                Section(header: Text("Title")){
                    TextField("Enter...", text: $txt)
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
                        coreDataViewModel.addCategorie(title: txt, symbol: symbol)
                        showSheet.toggle()
                    }
                    .disabled(txt.count < 3)
                }
            }
        }
        .accentColor(Color("Blue"))
    }
}

struct AddCategorieView_Previews: PreviewProvider {
    static var previews: some View {
        AddCategorieView(showSheet: .constant(true))
    }
}
