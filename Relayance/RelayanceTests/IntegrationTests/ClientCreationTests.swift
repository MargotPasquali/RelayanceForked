//
//  ClientCreationTests.swift
//  RelayanceTests
//
//  Created by Margot Pasquali on 19/02/2025.
//

import Foundation
import Testing
@testable import Relayance

@Suite("ClientCreationTests")
struct ClientCreationTests {

    var viewModel: ClientListViewModel!

    init() {
        viewModel = ClientListViewModel()
        viewModel.clientsList = []
    }

    @Test
    func createNewClientSuccess() throws {
        // Given
        let name = "Test User"
        let email = "test@example.com"

        // When
        let newClient = try viewModel.createNewClient(name: name, email: email)

        // Then
        #expect(newClient.name == name)
        #expect(newClient.email == email)
        #expect(viewModel.isClientExists(client: newClient))
    }

    @Test
    func createNewClientUpdatesClientsList() throws {
        // Given
        let initialCount = viewModel.clientsList.count
        let name = "Test User"
        let email = "test@example.com"

        // When
        let newClient = try viewModel.createNewClient(name: name, email: email)

        // Then
        #expect(viewModel.clientsList.count == initialCount + 1)
        #expect(viewModel.clientsList.contains { $0.name == newClient.name && $0.email == newClient.email })
    }

    @Test
    func createNewClientFailsWithInvalidEmail() async throws {
        // Given
        let invalidEmail = "invalid-email"

        // When / Then
        #expect(throws: ClientListViewModel.ClientListViewModelError.emailNotValid) {
            try viewModel.createNewClient(name: "Invalid User", email: invalidEmail)
        }
    }

    @Test
    func createNewClientFailsIfAlreadyExists() async throws {
        // Given
        let name = "Duplicate User"
        let email = "duplicate@example.com"
        _ = try viewModel.createNewClient(name: name, email: email)

        // When / Then
        #expect(throws: ClientListViewModel.ClientListViewModelError.clientAlreadyExists) {
            try viewModel.createNewClient(name: name, email: email)
        }
    }
}
