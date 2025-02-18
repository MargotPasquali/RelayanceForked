//
//  ClientListViewModel.swift
//  Relayance
//
//  Created by Margot Pasquali on 17/02/2025.
//

import Foundation

final class ClientListViewModel: ObservableObject {

    // MARK: - Properties

    @Published var clientsList: [Client] = []

    // MARK: - Init

    init() {
        loadClients()
    }

    // MARK: - Fonctions

    func loadClients() {
        self.clientsList = ModelData.chargement("Source.json")
    }

    func createNewClient(name: String, email: String) -> Client? {
        let currentDateString = Date.stringFromDate(Date.now) ?? ""
        let newClient = Client(name: name, email: email, creationDateString: currentDateString)

        if !isClientExists(client: newClient) {
            clientsList.append(newClient)
            return newClient
        }

        return nil
    }

    func isNewCLient(client: Client) -> Bool {
        let today = Date.now
        let creationDate = client.creationDate

        if today.getYear() != client.creationDate.getYear() ||
            today.getMonth() != client.creationDate.getMonth() ||
            today.getDay() != client.creationDate.getDay() {
            return false
        }
        return true
    }

    func isClientExists(client: Client) -> Bool {
        return clientsList.contains(where: { $0 == client })
    }

    func dateToStringFormatter(for client: Client) -> String {
        if let validDate = Date.dateFromString(client.creationDateString) {
            return Date.stringFromDate(validDate) ?? client.creationDateString
        }
        return client.creationDateString
    }

}
