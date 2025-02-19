//
//  Model.swift
//  Relayance
//
//  Created by Amandine Cousin on 10/07/2024.
//

import Foundation

public struct Client: Codable, Hashable {

    // MARK: - Properties

    public var name: String
    public var email: String
    public var creationDateString: String
    public var creationDate: Date {
        let date = Date.dateFromString(creationDateString) ?? Date.now
        return date
    }

    enum CodingKeys: String, CodingKey {
        case name = "nom"
        case email
        case creationDateString = "date_creation"
    }

    // MARK: - Init
    public init(name: String, email: String, creationDateString: String) {
        self.name = name
        self.email = email
        self.creationDateString = creationDateString
    }

}
