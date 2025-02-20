//
//  ClientDeletionTests.swift
//  RelayanceTests
//
//  Created by Margot Pasquali on 19/02/2025.
//
import XCTest
@testable import Relayance

final class ClientDeletionTests: XCTestCase {

    var viewModel: ClientListViewModel!

    override func setUp() {
        super.setUp()
        viewModel = ClientListViewModel()
        viewModel.clientsList = []
    }

    func testDeleteClientSuccess() throws {
        // Given
        let client = try viewModel.createNewClient(name: "John Doe", email: "john.doe@example.com")

        // When
        viewModel.deleteClient(name: client.name, email: client.email)

        // Then
        XCTAssertFalse(viewModel.isClientExists(client: client))
    }

    func testDeleteClientFailsIfNotFound() {
        // Given
        let initialCount = viewModel.clientsList.count

        // When
        viewModel.deleteClient(name: "Nonexistent", email: "no@email.com")

        // Then
        XCTAssertEqual(viewModel.clientsList.count, initialCount)
    }

    func testDeleteClientFailsIfListIsEmpty() {
        // Given
        viewModel.clientsList = []

        // When
        viewModel.deleteClient(name: "Random", email: "random@email.com")

        // Then
        XCTAssertTrue(viewModel.clientsList.isEmpty)
    }
}
