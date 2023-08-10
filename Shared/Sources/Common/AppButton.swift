//
//  AppButton.swift
//  Receipts Store (iOS)
//
//  Created by Robert Adamczyk on 10.08.23.
//

import SwiftUI

struct AppButton: View {

    let style: Style
    let action: () -> Void

    init(_ style: Style, action: @escaping () -> Void) {
        self.style = style
        self.action = action
    }

    var body: some View {
        Button(action: action) {
            makeBody()
        }
    }

    @ViewBuilder
    private func makeBody() -> some View {
        switch style {
        case .fill(let text):
            Text(text)
                .apply(.medium, size: .M, color: .white)
                .frame(height: 55)
                .frame(maxWidth: .infinity)
                .background {
                    RoundedRectangle(cornerRadius: 16)
                        .foregroundColor(appColor(.darkBlue))
                }
        case .appImage(let image):
            appImage(image)
        case .form(let formStyle):
            makeFormBody(for: formStyle)
        }
    }

    @ViewBuilder
    private func makeFormBody(for formStyle: FormStyle) -> some View {
        switch formStyle {
        case .checkmark(let text, let shouldShowCheckmark):
            HStack {
                Text(text)
                    .lineLimit(1)
                Spacer()
                if shouldShowCheckmark {
                    appImage(.checkmark)
                }
            }
            .apply(.regular, size: .M, color: .gray)
        case .navigation(let text, let value):
            HStack(spacing: 8) {
                Text(text)
                Spacer()
                if let value {
                    Text(value)
                }
                appImage(.chevronRight)
            }
            .apply(.regular, size: .M, color: .gray)
        }
    }
}

extension AppButton {

    enum Style {
        case fill(String)
        case appImage(AppImage)
        case form(FormStyle)
    }

    enum FormStyle {
        case navigation(String, String?)
        case checkmark(String, Bool)
    }
}
