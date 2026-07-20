//
//  SearchDebouncer.swift
//  BookStore
//
//  Created by Daniel Cano on 7/20/26.
//

import SwiftUI

final class SearchDebouncer {
    private var task: Task<Void, Never>?

    func submit(
        text: String,
        delay: Duration = .milliseconds(400),
        action: @escaping @Sendable (String) async -> Void
    ) {

        task?.cancel()

        task = Task {

            try? await Task.sleep(for: delay)

            guard !Task.isCancelled else { return }

            await action(text)
        }
    }
}
