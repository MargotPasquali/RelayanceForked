//
//  ClientService.swift
//  Relayance
//
//  Created by Damien Rivet on 20/02/2025.
//

import Foundation

protocol ClientServiceProtocol {
    func fetchClients() -> [Client]
    func save(clients: [Client])
}

struct JSONClientService: ClientServiceProtocol {

    private func getFilePath() -> URL {
        FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first!
            .appendingPathComponent("clients.json")
    }

    func fetchClients() -> [Client] {
        let fileURL = getFilePath()

        if
            FileManager.default.fileExists(atPath: fileURL.path),
            let data = try? Data(contentsOf: fileURL),
            let savedClients = try? JSONDecoder().decode([Client].self, from: data) {
            // If the file exists, load the saved clients
            return savedClients
        } else {
            // If no JSON file is found, load the default clients
            return ModelData.chargement("Source.json")
        }
    }

    func save(clients: [Client]) {
        if let data = try? JSONEncoder().encode(clients) {
            try? data.write(to: getFilePath())
        }
    }
}
