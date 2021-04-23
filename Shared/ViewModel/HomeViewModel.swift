//
//  HomeViewModel.swift
//  My Receipts (iOS)
//
//  Created by Robert Adamczyk on 23.04.21.
//

import SwiftUI

class HomeViewModel: ObservableObject {
    @Published var view: Views = .list
    @Published var showMenuBar = false
}
