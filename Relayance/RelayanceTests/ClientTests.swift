//
//  RelayanceTests.swift
//  RelayanceTests
//
//  Created by Amandine Cousin on 08/07/2024.
//

import Foundation
import XCTest
@testable import Relayance

final class ClientTests: XCTestCase {
    var client: Client!

    let clientName = "John Doe"
    let clientEmail = "john.doe@example.com"
    let clientDateCreationString = "2025-01-01"
    let expectedFormattedDate = Date.stringFromDate(Date.dateFromString(clientDateCreationString)!)

    override func setUp() {
        super.setUp()
        client = Client(name: clientName, email: clientEmail, creationDateString: clientDateCreationString)
    }

    func testInitClientSuccess() {
        // When
        let fakeClient = Client(name: clientName, email: clientEmail, creationDateString: clientDateCreationString)

        // Then
        XCTAssertEqual(clientEmail, fakeClient.email)
        XCTAssertEqual(clientName, fakeClient.name)
        XCTAssertEqual(expectedFormattedDate, fakeClient.dateToStringFormatter())

    }

    func testIsNewClientReturnsTrue() {
        Client(name: clientName, email: clientEmail, creationDateString: expectedFormattedDate)
    }

    func testIsNewClientReturnsFalse() {
        
    }

    func testCreateNewClientSuccess() {
        
    }

    func testCreateNewClientFailure() {
        
    }

    func testIsClientExistsReturnsTrue() {
        
    }

    func testIsClientExistsReturnsFalse() {
        
    }

    func testDateToStringFormatterSuccess() {
        
    }

    func testDateToStringFormatterFailure() {
        
    }
}
