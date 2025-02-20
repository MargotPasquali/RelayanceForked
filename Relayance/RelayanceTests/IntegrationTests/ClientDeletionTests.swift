//
//  ClientDeletionTests.swift
//  RelayanceTests
//
//  Created by Margot Pasquali on 19/02/2025.
//
import Foundation
import Testing
@testable import Relayance

@Suite("ClientDeletionTests")
struct ClientDeletionTests {
    var viewModel: ClientListViewModel!

    init() {
        viewModel = ClientListViewModel()
        viewModel.clientsList = []
    }

    @Test
    func deleteClientSuccess() throws {
        // Given
        let client = try viewModel.createNewClient(name: "John Doe", email: "john.doe@example.com")

        // When
        viewModel.deleteClient(name: client.name, email: client.email)

        // Then
        #expect(!viewModel.isClientExists(client: client))
    }

    @Test
    func deleteClientFailsIfNotFound() {
        // Given
        let initialCount = viewModel.clientsList.count

        // When
        viewModel.deleteClient(name: "Nonexistent", email: "no@email.com")

        // Then
        #expect(viewModel.clientsList.count == initialCount)
    }

    @Test
    func deleteClientFailsIfListIsEmpty() {
        // Given
        viewModel.clientsList = []

        // When
        viewModel.deleteClient(name: "Random", email: "random@email.com")

        // Then
        #expect(viewModel.clientsList.isEmpty)
    }
}
