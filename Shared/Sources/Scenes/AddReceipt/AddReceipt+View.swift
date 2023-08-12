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
        
        VStack(spacing: 0) {
            Form {
                Section {
                    ZStack {
                        Color(UIColor.systemGroupedBackground)

                        AddReceiptImageView()
                            .padding(5)
                    }
                    .listRowInsets(EdgeInsets())
                }
                Section(header: Text(appText(.generic(.informations)))) {
                    TextField(appText(.generic(.title)),
                              text: $viewModel.newReceipt.title)
                        .apply(.regular, size: .M, color: .gray)
                    if !viewModel.categories.isEmpty {
                        AppButton(.form(.navigation(appText(.generic(.categories)),
                                                    viewModel.newReceipt.categorie?.title)),
                                  action: viewModel.onCategoriesTapped)

                    }
                    AppButton(.form(.navigation(appText(.generic(.warranty)),
                                                viewModel.endOfWarrantyText)), action: viewModel.onWarrantyTapped)
                }

                Section(header: Text(appText(.addReceipt(.purchaseSection)))) {
                    DatePicker(selection: $viewModel.newReceipt.dateOfPurchase,
                               displayedComponents: .date) {
                        Text(appText(.generic(.purchaseDate)))
                            .apply(.regular, size: .M, color: .gray)
                    }
                }
            }
            AppButton(.fill(appText(.generic(.saveButton))),
                      action: viewModel.onSaveButtonTapped)
                .disabled(!viewModel.meetsRequirementsToCreateReceipt)
                .stickyButton
        }
        .toolbar {
            ToolbarItemGroup(placement: .navigationBarTrailing) {
                AppButton(.appImage(.xmark), action: viewModel.onCloseButtonTapped)
            }
        }
        .navigationTitle(viewModel.navigationTitle)
        .environmentObject(viewModel)
        .onAppear(perform: viewModel.onViewAppear)
    }
}
