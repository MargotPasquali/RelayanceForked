//
//  ClientMock.swift
//  RelayanceTests
//
//  Created by Margot Pasquali on 17/02/2025.
//

import Relayance
import Foundation

struct ClientMock {
    static let fakeClients: [Client] = [
        Client(name: "Alice Dupont", email: "alice.dupont@example.com", creationDateString: "2024-06-15T13:45:00Z"),
        Client(name: "Bob Martin", email: "bob.martin@example.com", creationDateString: "15-12-2023"),
        Client(name: "Charlie Durand", email: "charlie.durand@example.com", creationDateString: "2022-06-30T08:30:00Z"),
        Client(name: "David Lambert", email: "david.lambert@example.com", creationDateString: "17-02-2025"),
        Client(name: "Emma Leclerc", email: "emma.leclerc@example.com", creationDateString: "2020-09-10T07:15:00Z")
    ]

    static var fakeclient: Client {
        return Client(name: "John Doe", email: "john.doe@example.com", creationDateString: "2024-06-15T13:45:00Z")
    }
}
