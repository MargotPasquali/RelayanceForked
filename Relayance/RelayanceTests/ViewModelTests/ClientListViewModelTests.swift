//
//  ClientListViewModel.swift
//  RelayanceTests
//
//  Created by Margot Pasquali on 17/02/2025.
//

import Foundation
import Testing
@testable import Relayance

extension Tag {

    @Tag
    static var viewModel: Self

    @Tag
    static var client: Self
}

@Suite("Client list viewmodel", .tags(.viewModel))
struct ClientListViewModelTests {

    var viewModel: ClientListViewModel!

    init() {
        viewModel = ClientListViewModel()
        viewModel.clientsList = []
    }

    @Test(.tags(.viewModel, .client))
    func initLoadsClientsFromStorage() {
        // Given
        let testClient = Client(name: "Test User", email: "test@example.com", creationDateString: "2024-06-15")
        let viewModel = ClientListViewModel()
        viewModel.clientsList.append(testClient)

        // When
        viewModel.saveClients()
        viewModel.loadClients()

        let loadedClients = viewModel.clientsList

        // Then
        #expect(!loadedClients.isEmpty, "The client list should not be empty after initialization")
    }

    @Test(.tags(.client))
    func saveClientsWritesToFile() throws {
        // Given
        _ = try viewModel.createNewClient(name: "Test User", email: "test@example.com")
        let fileURL = viewModel.getFilePath()

        // When
        viewModel.saveClients()

        // Then
        #expect(FileManager.default.fileExists(atPath: fileURL.path))

        let data = try Data(contentsOf: fileURL)
        #expect(!data.isEmpty, "The clients.json file should not be empty after saving")
    }

    @Test("Test is new client",
        arguments: [
            ("Test User", "test@example.com", Date.stringFromDate(Date.now), true),
            ("Alice Dupont", "alice.dupont@example.com", "2024-06-15", false)
        ]
    )
    func shouldValidateIfNewClient(name: String, email: String, creationDateString: String, returnValue: Bool) {
        // Given
        let client = Client(name: "", email: "", creationDateString: creationDateString)

        // When
        let isNew = viewModel.isNewCLient(client: client)

        // Then
        #expect(returnValue == isNew)
    }

    @Test
    func isClientExistsReturnsTrue() {
        // Given
        let existingClient = Client(name: "Bob Martin",
                                    email: "bob.martin@example.com",
                                    creationDateString: "2023-12-15")
        viewModel.clientsList.append(existingClient)

        // When
        let exists = viewModel.isClientExists(client: existingClient)

        // Then
        #expect(exists)
    }

    @Test
    func isClientExistsReturnsFalse() {
        // Given
        let nonExistingClient = Client(name: "Bob", email: "bob@example.com", creationDateString: "2024-01-01")

        // When
        let exists = viewModel.isClientExists(client: nonExistingClient)

        // Then
        #expect(!exists)
    }

    @Test
    func shouldReturnDateToString() {
        // Given
        let today = Date.now
        let todayString = Date.stringFromDate(today)
        let client = Client(name: "Test User", email: "test@example.com", creationDateString: todayString)

        // When
        let value = viewModel.dateToStringFormatter(for: client)

        // Then
        #expect(todayString == value)
    }
}
