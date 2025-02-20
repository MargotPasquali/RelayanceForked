//
//  ClientListViewModel.swift
//  RelayanceTests
//
//  Created by Margot Pasquali on 17/02/2025.
//

import XCTest
@testable import Relayance

final class ClientListViewModelTests: XCTestCase {

    var viewModel: ClientListViewModel!

    override func setUp() {
        super.setUp()
        viewModel = ClientListViewModel()
        viewModel.clientsList = []
    }

    func testInitLoadsClientsFromStorage() {
        // Given
        let testClient = Client(name: "Test User", email: "test@example.com", creationDateString: "2024-06-15")
        let viewModel = ClientListViewModel()
        viewModel.clientsList.append(testClient)

        // When
        viewModel.saveClients()
        viewModel.loadClients()

        let loadedClients = viewModel.clientsList

        // Then
        XCTAssertFalse(loadedClients.isEmpty, "The client list should not be empty after initialization")
    }

    func testSaveClientsWritesToFile() throws {
        // Given
        try viewModel.createNewClient(name: "Test User",
                                      email: "test@example.com")
        let fileURL = viewModel.getFilePath()

        // When
        viewModel.saveClients()

        // Then
        XCTAssertTrue(FileManager.default.fileExists(atPath: fileURL.path))

        let data = try Data(contentsOf: fileURL)
        XCTAssertFalse(data.isEmpty, "The clients.json file should not be empty after saving")
    }

    func testIsNewClientReturnsTrue() {
        // Given
        let today = Date.now
        let todayString = Date.stringFromDate(today) ?? ""
        let client = Client(name: "Test User", email: "test@example.com", creationDateString: todayString)

        // When
        let isNew = viewModel.isNewCLient(client: client)

        // Then
        XCTAssertTrue(isNew)
    }

    func testIsNewClientReturnsFalse() {
        // Given
        let oldClient = Client(name: "Alice Dupont",
                               email: "alice.dupont@example.com",
                               creationDateString: "2024-06-15")

        // When
        let isNew = viewModel.isNewCLient(client: oldClient)

        // Then
        XCTAssertFalse(isNew)
    }

    func testIsClientExistsReturnsTrue() {
        // Given
        let existingClient = Client(name: "Bob Martin",
                                    email: "bob.martin@example.com",
                                    creationDateString: "2023-12-15")
        viewModel.clientsList.append(existingClient)

        // When
        let exists = viewModel.isClientExists(client: existingClient)

        // Then
        XCTAssertTrue(exists)
    }

    func testIsClientExistsReturnsFalse() {
        // Given
        let nonExistingClient = Client(name: "Bob", email: "bob@example.com", creationDateString: "2024-01-01")

        // When
        let exists = viewModel.isClientExists(client: nonExistingClient)

        // Then
        XCTAssertFalse(exists)
    }
}
