//
//  RelayanceTests.swift
//  RelayanceTests
//
//  Created by Amandine Cousin on 08/07/2024.
//

import Foundation
import Testing
@testable import Relayance

@Suite("ClientTests")
struct ClientTests {
    var client: Client!
    var expectedFormattedDate: String!

    let clientName = "John Doe"
    let clientEmail = "john.doe@example.com"
    let clientDateCreationString = "2025-01-01"

    init() {
        client = Client(name: clientName, email: clientEmail, creationDateString: clientDateCreationString)

        if let date = Date.dateFromString(clientDateCreationString) {
            expectedFormattedDate = Date.stringFromDate(date)
        }
    }

    @Test
    func initClientSuccess() {
        // Given
        let fakeClient = Client(name: clientName, email: clientEmail, creationDateString: clientDateCreationString)

        // When / Then
        #expect(clientEmail == fakeClient.email)
        #expect(clientName == fakeClient.name)

        let expectedDate = Date.dateFromString(clientDateCreationString)
        let expectedFormattedDate = Date.stringFromDate(expectedDate!)

        #expect(expectedFormattedDate == Date.stringFromDate(fakeClient.creationDate))
    }

    @Test
    func dateConversionSuccess() {
        // When
        let convertedDate = client.creationDate

        // Then
        #expect(convertedDate != nil)
    }
}
