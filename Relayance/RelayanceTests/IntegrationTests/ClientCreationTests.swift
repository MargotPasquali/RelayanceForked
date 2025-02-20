//
//  ClientCreationTests.swift
//  RelayanceTests
//
//  Created by Margot Pasquali on 19/02/2025.
//

import XCTest
@testable import Relayance

final class ClientCreationTests: XCTestCase {

    var viewModel: ClientListViewModel!

    override func setUp() {
        super.setUp()
        viewModel = ClientListViewModel()
        viewModel.clientsList = []
    }

    func testCreateNewClientSuccess() throws {
        // Given
        let name = "Test User"
        let email = "test@example.com"

        // When
        let newClient = try viewModel.createNewClient(name: name, email: email)

        // Then
        XCTAssertEqual(newClient.name, name)
        XCTAssertEqual(newClient.email, email)
        XCTAssertTrue(viewModel.isClientExists(client: newClient))
    }

    func testCreateNewClientUpdatesClientsList() throws {
        // Given
        let initialCount = viewModel.clientsList.count
        let name = "Test User"
        let email = "test@example.com"

        // When
        let newClient = try viewModel.createNewClient(name: name, email: email)

        // Then
        XCTAssertEqual(viewModel.clientsList.count, initialCount + 1)
        XCTAssertTrue(viewModel.clientsList.contains { $0.name == newClient.name && $0.email == newClient.email })
    }

    func testCreateNewClientFailsWithInvalidEmail() {
        // Given
        let invalidEmail = "invalid-email"

        // When / Then
        XCTAssertThrowsError(try viewModel.createNewClient(name: "Invalid User", email: invalidEmail)) { error in
            XCTAssertEqual(error as? ClientListViewModel.ClientListViewModelError, .emailNotValid)
        }
    }

    func testCreateNewClientFailsIfAlreadyExists() throws {
        // Given
        let name = "Duplicate User"
        let email = "duplicate@example.com"
        _ = try viewModel.createNewClient(name: name, email: email)

        // When / Then
        XCTAssertThrowsError(try viewModel.createNewClient(name: name, email: email)) { error in
            XCTAssertEqual(error as? ClientListViewModel.ClientListViewModelError, .clientAlreadyExists)
        }
    }
}
