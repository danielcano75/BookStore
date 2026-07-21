//
//  BooksServiceTests.swift
//  BookStore
//
//  Created by Daniel Cano on 7/20/26.
//

import Testing
@testable import BookStore

@Suite(.tags(.service))
struct BooksServiceTests {

    @Test func fetchBooks_whenNotSetup_throwsMissingNetworking() async {
        let service = BooksService()
        await #expect(throws: BooksServiceErrors.missingSetupNetworking) {
            try await service.fetchBooks(page: nil, search: nil)
        }
    }

    @Test func fetchBooks_whenSetup_returnsModelFromAPIClient() async throws {
        let expected = BooksModel.stub(results: [.stub(id: 42)])
        let mockClient = MockAPIClient(stubbedModel: expected)
        let service = BooksService(networking: mockClient)

        let result = try await service.fetchBooks(page: 1, search: nil)

        #expect(result.results.first?.id == 42)
        #expect(mockClient.callCount == 1)
    }

    @Test func fetchBooks_whenAPIClientThrows_propagatesError() async {
        let mockClient = MockAPIClient(shouldThrow: true)
        let service = BooksService(networking: mockClient)

        await #expect(throws: (any Error).self) {
            try await service.fetchBooks(page: nil, search: nil)
        }
    }
}
