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
        viewModel.clientsList = []
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
                               creationDateString: "2024-06-15")

        // When
        let isNew = viewModel.isNewCLient(client: oldClient)

        // Then
        XCTAssertFalse(isNew)
    }

    func testCreateNewClientSuccess() throws {
        // Given
        let name = "Test"
        let email = "test@test.com"

        // When
        let newClient = try viewModel.createNewClient(name: name, email: email)

        // Then
        XCTAssertEqual(newClient.name, name)
        XCTAssertEqual(newClient.email, email)
    }

    func testCreateNewClientFailure() {
        // Given
        let name = "Test"
        let email = "test@test.com"
        _ = try? viewModel.createNewClient(name: name, email: email)

        // When / Then
        XCTAssertThrowsError(try viewModel.createNewClient(name: name, email: email)) { error in
            XCTAssertEqual(error as? ClientListViewModel.ClientListViewModelError, .clientAlreadyExists)
        }
    }

    func testIsClientExistsReturnsTrue() {
        // Given
        let existingClient = ClientMock.fakeClients.first!
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

    func testDeleteClientRemovesClient() throws {
        // Given
        let clientToDelete = try viewModel.createNewClient(name: "Alice Dupont", email: "alice@example.com")

        // When
        viewModel.deleteClient(name: clientToDelete.name, email: clientToDelete.email)

        // Then
        XCTAssertFalse(viewModel.isClientExists(client: clientToDelete))
    }

    func testDateToStringFormatterSuccess() {
        // Given
        let expectedDate = Date.dateFromString(mockClient.creationDateString)
        let expectedFormattedDate = Date.stringFromDate(expectedDate!)

        // When
        let formattedDate = viewModel.dateToStringFormatter(for: mockClient)

        // Then
        XCTAssertEqual(formattedDate, expectedFormattedDate)
    }

    func testDateToStringFormatterReturnsOriginalStringWhenDateConversionFails() {
        // Given
        let invalidClient = Client(name: "Invalid User",
                                   email: "invalid@example.com",
                                   creationDateString: "invalid-date")

        // When
        let formattedDate = viewModel.dateToStringFormatter(for: invalidClient)

        // Then
        XCTAssertEqual(formattedDate, invalidClient.creationDateString)
    }

}
