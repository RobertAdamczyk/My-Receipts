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
    @EnvironmentObject var coreDataViewModel: CoreDataViewModel
    var body: some View {
        NavigationView{
            Form{
                Section(header: Text("Title")){
                    TextField("Enter...", text: $txt)
                }
                
            }
            .navigationTitle("New Categorie")
            .toolbar{
                ToolbarItemGroup(placement: .navigationBarTrailing) {
                    Button("Done") {
                        coreDataViewModel.addCategorie(title: txt)
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
