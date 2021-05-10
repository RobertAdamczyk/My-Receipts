//
//  CategoriesSettings.swift
//  My Receipts (iOS)
//
//  Created by Robert Adamczyk on 10.05.21.
//

import SwiftUI

struct CategoriesSettings: View {
    var body: some View {
        List{
            
        }
        .navigationBarTitle("Categories", displayMode: .inline)
        .toolbar {
            ToolbarItemGroup(placement: .navigationBarTrailing) {
                Button("Add") {
                }
            }
        }
    }
}

struct CategoriesSettings_Previews: PreviewProvider {
    static var previews: some View {
        CategoriesSettings()
    }
}
