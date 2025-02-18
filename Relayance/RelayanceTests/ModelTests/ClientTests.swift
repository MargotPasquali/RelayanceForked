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
    var expectedFormattedDate: String!

    let clientName = "John Doe"
    let clientEmail = "john.doe@example.com"
    let clientDateCreationString = "2025-01-01"

    override func setUp() {
        super.setUp()
        client = Client(name: clientName, email: clientEmail, creationDateString: clientDateCreationString)

        if let date = Date.dateFromString(clientDateCreationString) {
            expectedFormattedDate = Date.stringFromDate(date)
        } else {
            XCTFail("Date conversion failed")
        }
    }

    func testInitClientSuccess() {
        // Given
        let fakeClient = Client(name: clientName, email: clientEmail, creationDateString: clientDateCreationString)

        // When / Then
        XCTAssertEqual(clientEmail, fakeClient.email)
        XCTAssertEqual(clientName, fakeClient.name)

        let expectedDate = Date.dateFromString(clientDateCreationString)
        let expectedFormattedDate = Date.stringFromDate(expectedDate!)

        XCTAssertEqual(expectedFormattedDate, Date.stringFromDate(fakeClient.creationDate))
    }

    func testDateConversionSuccess() {
        // When
        let convertedDate = client.creationDate

        // Then
        XCTAssertNotNil(convertedDate)
    }
}
