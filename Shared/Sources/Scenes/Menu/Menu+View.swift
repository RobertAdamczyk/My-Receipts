//
//  MenuBar.swift
//  My Receipts (iOS)
//
//  Created by Robert Adamczyk on 23.04.21.
//

import SwiftUI

struct MenuView: View {

    @StateObject var viewModel: MenuViewModel

    static let widthMenu: CGFloat = 200

    init(coordinator: Coordinator) {
        self._viewModel = .init(wrappedValue: .init(coordinator: coordinator))
    }

    var body: some View {
        HStack {
            VStack(alignment: .leading ,spacing: 16) {
                Divider()
                ForEach(viewModel.dataSource) { source in
                    Button(action: source.action) {
                        HStack {
                            appImage(source.image)
                                .apply(.regular, size: .M, color: .darkBlue)
                            Text(source.text)
                                .apply(.regular, size: .M, color: .gray)
                            Spacer(minLength: 0)
                        }
                    }
                    Divider()
                }
                Spacer()
            }
            .padding(.top, 128)
            .padding(.horizontal, 16)
            .frame(width: MenuView.widthMenu)
            .background {
                Rectangle()
                    .fill(appGradient(.primary))
            }
            .overlay(alignment: .trailing) {
                Rectangle()
                    .frame(width: 1)
                    .foregroundColor(appColor(.black))
            }
            if viewModel.shouldShowMenu {
                Color.clear
                    .contentShape(Rectangle())
                    .onTapGesture(perform: viewModel.hideMenu)
            }else {
                Color.clear
            }
        }
        .ignoresSafeArea()
        .offset(x: -MenuView.widthMenu)
    }
}
