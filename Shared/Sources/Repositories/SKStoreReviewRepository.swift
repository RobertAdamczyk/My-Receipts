//
//  SKStoreReviewRepository.swift
//  Receipts Store (iOS)
//
//  Created by Robert Adamczyk on 12.08.23.
//

import StoreKit
import SwiftUI

final class SKStoreReviewRepository {

    @AppStorage("currentCount") private var currentCount: Int = 0
    @AppStorage("lastCounted") private var lastCounted: Double = Date.now.timeIntervalSince1970

    private let countToRequest: Int = 3
    private let timeInSecToIncreaseCount: Double = 20 // 3600 * 24 TODO: Make this back !

    private var requestReviewTask: Task<(), Never>?

    init() {
        setupDidBecomeActiveObserver()
    }

    private func setupDidBecomeActiveObserver() {
        Task {
            for await _ in await NotificationCenter.default.notifications(named: UIApplication.didBecomeActiveNotification) {
                requestReviewIfNeeded()
                #if DEBUG
                print("REVIEW: currentCount:\(currentCount) lastCounted:\(lastCounted)")
                #endif
            }
        }
    }

    private func requestReviewIfNeeded() {
        let lastCountedDate: Date = .init(timeIntervalSince1970: lastCounted)
        if lastCountedDate.addingTimeInterval(timeInSecToIncreaseCount) < .now {
            if currentCount >= countToRequest {
                requestReview()
            } else {
                currentCount += 1
                lastCounted = Date.now.timeIntervalSince1970
            }
        }
    }

    private func requestReview() {
        requestReviewTask?.cancel()
        requestReviewTask = Task {
            // Delay for two seconds to avoid interrupting the person using the app.
            // Use the equation n * 10^9 to convert seconds to nanoseconds.
            try? await Task.sleep(nanoseconds: UInt64(2e9))
            if let windowScene = await UIApplication.shared.keyWindow?.windowScene {
                await SKStoreReviewController.requestReview(in: windowScene)
                currentCount = 0
            }
        }
    }
}

private extension UIApplication {

    var keyWindow: UIWindow? {
        // Get connected scenes
        return self.connectedScenes
            // Keep only active scenes, onscreen and visible to the user
            .filter { $0.activationState == .foregroundActive }
            // Keep only the first `UIWindowScene`
            .first(where: { $0 is UIWindowScene })
            // Get its associated windows
            .flatMap({ $0 as? UIWindowScene })?.windows
            // Finally, keep only the key window
            .first(where: \.isKeyWindow)
    }

}
