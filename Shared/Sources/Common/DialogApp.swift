//
//  DialogApp.swift
//  Receipts Store (iOS)
//
//  Created by Robert Adamczyk on 06.08.23.
//

import SwiftUI

struct DialogApp: ViewModifier {

    @Binding var item: DialogApp.Model?

    @State private var showDialog: Bool = false

    init(item: Binding<DialogApp.Model?>) {
        self._item = item
        self.showDialog = item.wrappedValue != nil
    }

    func body(content: Content) -> some View {
        makeContent(content: content)
            .onChange(of: item) { newValue in
                showDialog = newValue != nil
            }
            .onChange(of: showDialog) { newValue in
                if !newValue {
                    item = nil
                }
            }
    }

    @ViewBuilder
    private func makeContent(content: Content) -> some View {
        if UIScreen.main.traitCollection.userInterfaceIdiom == .pad {
            content
                .alert(item?.alertTitle ?? "", isPresented: $showDialog, actions: {
                    makeBody()
                    SwiftUI.Button(appText(.generic(.cancel)),
                                   role: .cancel) { }
                })
        } else {
            content
                .confirmationDialog("", isPresented: $showDialog) {
                    makeBody()
                }
        }
    }

    @ViewBuilder
    private func makeBody() -> some View {
        switch item {
        case .loadPhoto(let takePhoto, let selectPhoto):
            SwiftUI.Button(appText(.dialogApp(.takePhoto)),
                           action: takePhoto)
            SwiftUI.Button(appText(.dialogApp(.useExisting)),
                           action: selectPhoto)
        default:
            EmptyView()
        }
    }
}

extension DialogApp {

    enum Model: Equatable {

        case loadPhoto(() -> Void, () -> Void)

        var alertTitle: String {
            switch self {
            case .loadPhoto: return appText(.dialogApp(.image))
            }
        }

        static func == (lhs: DialogApp.Model, rhs: DialogApp.Model) -> Bool {
            switch (lhs, rhs) {
            case (.loadPhoto, .loadPhoto): return true
            }
        }
    }
}

extension View {
    func dialogApp(item: Binding<DialogApp.Model?>) -> some View {
        modifier(DialogApp(item: item))
    }
}
