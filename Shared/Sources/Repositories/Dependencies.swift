//
//  Dependencies.swift
//  Receipts Store (iOS)
//
//  Created by Robert Adamczyk on 06.08.23.
//

import Foundation

struct Dependencies {

    let notificationsRepository: NotificationsRepository
    let coreDataService: CoreDataService

    private let skStoreReviewRepository: SKStoreReviewRepository

    init(notificationsRepository: NotificationsRepository,
         coreDataService: CoreDataService,
         skStoreReviewRepository: SKStoreReviewRepository) {
        self.notificationsRepository = notificationsRepository
        self.coreDataService = coreDataService
        self.skStoreReviewRepository = skStoreReviewRepository
    }
}
