//
//  AddReceipt.swift
//  My Receipts (iOS)
//
//  Created by Robert Adamczyk on 23.04.21.
//

import SwiftUI

struct AddReceipt: View {

    enum Context {
        case new
        case edit(Receipt)
    }

    @StateObject var viewModel: AddReceiptViewModel

    init(coordinator: Coordinator, parentCoordinator: Coordinator, context: Context) {
        self._viewModel = .init(wrappedValue: .init(coordinator: coordinator,
                                                    parentCoordinator: parentCoordinator,
                                                    context: context))
    }
    
    var body: some View {
        
        Form {
            Section {
                ZStack {
                    Color(UIColor.systemGroupedBackground)
                        
                    AddReceiptImageView()
                        .padding(5)
                }
                .listRowInsets(EdgeInsets())
            }
            Section(header: Text("Info")) {
                TextField("Title", text: $viewModel.newReceipt.title)
                    .apply(.regular, size: .M, color: .gray)
                if !viewModel.categories.isEmpty {
                    Button(action: viewModel.onCategoriesTapped) {
                        HStack(spacing: 8) {
                            Text("Categorie")
                            Spacer()
                            Text(viewModel.newReceipt.categorie?.title ?? "")
                            Image(systemName: "chevron.right")
                        }
                        .apply(.regular, size: .M, color: .gray)
                    }
                    
                }
                Button(action: viewModel.onWarrantyTapped) {
                    HStack(spacing: 8) {
                        Text("Guarantee")
                        Spacer()
                        Text(viewModel.warranty ? "\(viewModel.newReceipt.endOfWarranty, style: .date)" : "")
                        Image(systemName: "chevron.right")
                    }
                    .apply(.regular, size: .M, color: .gray)
                }
            }
            
            Section(header: Text("Purchase")) {
                DatePicker(selection: $viewModel.newReceipt.dateOfPurchase,
                           displayedComponents: .date) {
                    Text("Date of Purchase")
                        .apply(.regular, size: .M, color: .gray)
                }
            }
        }
        .toolbar {
            ToolbarItemGroup(placement: .navigationBarLeading) {
                Button(action:{
                    viewModel.onSaveButtonTapped()
                }){
                    Text("Done")
                }
                .disabled(!viewModel.meetsRequirementsToCreateReceipt)
            }
            ToolbarItemGroup(placement: .navigationBarTrailing) {
                Button(action:{
                    viewModel.onCloseButtonTapped()
                }){
                    Image(systemName: "xmark")
                }
            }
        }
        .navigationTitle(viewModel.navigationTitle)
        .environmentObject(viewModel)
        .onAppear(perform: viewModel.onViewAppear)
    }
}