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
    var mockClient: Client!

    override func setUp() {
        super.setUp()
        viewModel = ClientListViewModel()
        mockClient = ClientMock.fakeclient
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
                               creationDateString: "2024-06-15T13:45:00Z")

        // When
        let isNew = viewModel.isNewCLient(client: oldClient)

        // Then
        XCTAssertFalse(isNew)
    }

    func testCreateNewClientSuccess() {
        // Given
        let name = "Test"
        let email = "test@test.com"

        // When
        let newClient = viewModel.createNewClient(name: name, email: email)

        // Then
        XCTAssertNotNil(newClient, "The client should be created")
        XCTAssertEqual(newClient?.name, name)
        XCTAssertEqual(newClient?.email, email)
    }

    func testCreateNewClientFailure() {
        // Given
        let name = "Test"
        let email = "test@test.com"
        _ = viewModel.createNewClient(name: name, email: email)

        // When
        let duplicateClient = viewModel.createNewClient(name: name, email: email)

        // Then
        XCTAssertNil(duplicateClient, "The client should not be created again if it already exists")
    }

    func testIsClientExistsReturnsTrue() {
        // Given
        let existingClient = ClientMock.fakeClients.first!
        viewModel.clientsList.append(existingClient)

        // When
        let exists = viewModel.isClientExists(client: existingClient)

        // Then
        XCTAssertTrue(exists, "The client should be recognized as existing")
    }

    func testIsClientExistsReturnsFalse() {
        // Given
        let nonExistingClient = Client(name: "Bob", email: "bob@example.com", creationDateString: "2024-01-01")

        // When
        let exists = viewModel.isClientExists(client: nonExistingClient)

        // Then
        XCTAssertFalse(exists, "The client should not be found")
    }

    func testCreateNewClientFailsWhenClientAlreadyExists() {
        // Given
        let name = "Test User"
        let email = "test@example.com"
        _ = viewModel.createNewClient(name: name, email: email)

        // When
        let duplicateClient = viewModel.createNewClient(name: name, email: email)

        // Then
        XCTAssertNil(duplicateClient, "Duplicate client should not be created")
    }

    func testDateToStringFormatterSuccess() {
        // Given
        let expectedDate = Date.dateFromString(mockClient.creationDateString)
        let expectedFormattedDate = Date.stringFromDate(expectedDate!)

        // When
        let formattedDate = viewModel.dateToStringFormatter(for: mockClient)

        // Then
        XCTAssertEqual(formattedDate, expectedFormattedDate, "The date formatting is incorrect")
    }

    func testDateToStringFormatterReturnsOriginalStringWhenDateConversionFails() {
        // Given
        let invalidClient = Client(name: "Invalid User",
                                   email: "invalid@example.com",
                                   creationDateString: "invalid-date")

        // When
        let formattedDate = viewModel.dateToStringFormatter(for: invalidClient)

        // Then
        XCTAssertEqual(formattedDate, invalidClient.creationDateString,
                       "Should return the original string if date conversion fails")
    }

}
