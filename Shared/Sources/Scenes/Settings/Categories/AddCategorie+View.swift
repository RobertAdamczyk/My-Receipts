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
        NavigationView {
            VStack(spacing: 0) {
                Form {
                    Section(header: Text(appText(.generic(.title)))){
                        TextField(appText(.generic(.enter)), text: $title)
                            .apply(.regular, size: .M, color: .gray)
                    }
                    Section(header: Text(appText(.generic(.symbol)))){
                        TextField(appText(.generic(.enter)), text: $symbol)
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
                AppButton(.fill(appText(.generic(.saveButton)))) {
                    completion(title, symbol)
                }
                .disabled(title.count < 3)
                .stickyButton
            }
            .navigationTitle(appText(.generic(.newCategory)))
        }
    }
}
