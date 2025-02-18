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
                return "Le client existe déjà."
            case .emailNotValid:
                return "L'email n'est pas valide."
            case .unableToCreateClient:
                return "Impossible de créer le client."
            }
        }
    }

    // MARK: - Properties

    @Published var clientsList: [Client] = []

    // MARK: - Init

    init() {
        loadClients()
    }

    // MARK: - Fonctions

    func getFilePath() -> URL {
        FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first!
            .appendingPathComponent("clients.json")
    }

    func saveClients() {
        if let data = try? JSONEncoder().encode(clientsList) {
            try? data.write(to: getFilePath())
        }
    }

    func loadClients() {
        let fileURL = getFilePath()

        if FileManager.default.fileExists(atPath: fileURL.path) {
            // If the file exists, load the saved clients
            if let data = try? Data(contentsOf: fileURL),
               let savedClients = try? JSONDecoder().decode([Client].self, from: data) {
                clientsList = savedClients
            }
        } else {
            // If no JSON file is found, load the default clients
            clientsList = ModelData.chargement("Source.json")
        }
    }


    func createNewClient(name: String, email: String) throws -> Client {
        guard isEmailValid(email: email) else {
            throw ClientListViewModelError.emailNotValid
        }

        let currentDateString = Date.stringFromDate(Date.now) ?? ""
        let newClient = Client(name: name, email: email, creationDateString: currentDateString)

        guard !isClientExists(client: newClient) else {
            throw ClientListViewModelError.clientAlreadyExists
        }

        clientsList.append(newClient)
        saveClients()

        return newClient
    }

    func isNewCLient(client: Client) -> Bool {
        let today = Date.now
        _ = client.creationDate

        if today.getYear() != client.creationDate.getYear() ||
            today.getMonth() != client.creationDate.getMonth() ||
            today.getDay() != client.creationDate.getDay() {
            return false
        }
        return true
    }

    func isClientExists(client: Client) -> Bool {
        return clientsList.contains { $0.name == client.name && $0.email == client.email }
    }

    func dateToStringFormatter(for client: Client) -> String {
        if let validDate = Date.dateFromString(client.creationDateString) {
            return Date.stringFromDate(validDate) ?? client.creationDateString
        }
        return client.creationDateString
    }

    func isEmailValid(email: String) -> Bool {
        let emailRegex = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,}"
        return email.range(of: emailRegex, options: .regularExpression, range: nil, locale: nil) != nil
    }

}
