//
//  ClientListViewModel.swift
//  Relayance
//
//  Created by Margot Pasquali on 17/02/2025.
//

import Foundation

final class ClientListViewModel: ObservableObject {

    // MARK: - Enum

    enum ClientListViewModelError: Error {
        case clientAlreadyExists
        case emailNotValid
        case unableToCreateClient

        var localizedDescription: String {
            switch self {
            case .clientAlreadyExists:
                "Le client existe déjà."
            case .emailNotValid:
                "L'email n'est pas valide."
            case .unableToCreateClient:
                "Impossible de créer le client."
            }
        }
    }

    private let clientService: ClientServiceProtocol

    // MARK: - Properties

    @Published var clientsList: [Client] = []

    // MARK: - Init

    init(clientService: ClientServiceProtocol = JSONClientService()) {
        self.clientService = clientService

        loadClients()
    }

    // MARK: - Fonctions

    func saveClients() {
        clientService.save(clients: clientsList)
    }

    func loadClients() {
        clientsList = clientService.fetchClients()
    }

    func createNewClient(name: String, email: String) throws -> Client {
        guard isEmailValid(email: email) else {
            throw ClientListViewModelError.emailNotValid
        }

        let currentDateString = Date.stringFromDate(Date.now)
        let newClient = Client(name: name, email: email, creationDateString: currentDateString)

        guard !isClientExists(client: newClient) else {
            throw ClientListViewModelError.clientAlreadyExists
        }

        clientsList.append(newClient)
        saveClients()

        return newClient
    }

    // TODO: Extract this into a service or a manager
    func deleteClient(name: String, email: String) {
        if let index = clientsList.firstIndex(where: { $0.name == name && $0.email == email }) {
            clientsList.remove(at: index)
            saveClients()
        }

        loadClients()
    }

    func isNewCLient(client: Client) -> Bool {
        let today = Date.now

        return !(today.getYear() != client.creationDate.getYear() ||
                today.getMonth() != client.creationDate.getMonth() ||
                today.getDay() != client.creationDate.getDay())
    }

    func isClientExists(client: Client) -> Bool {
        clientsList.contains { $0.name == client.name && $0.email == client.email }
    }

    func dateToStringFormatter(for client: Client) -> String {
        if let validDate = Date.dateFromString(client.creationDateString) {
            Date.stringFromDate(validDate)
        } else {
            client.creationDateString
        }
    }

    func isEmailValid(email: String) -> Bool {
        email.range(
            of: "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,}",
            options: .regularExpression,
            range: nil,
            locale: nil
        ) != nil
    }
}
