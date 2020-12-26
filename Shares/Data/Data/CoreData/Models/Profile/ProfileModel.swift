//
//  ProfileModel.swift
//  Data
//
//  Created by Thatchaphon Sritrakul on 25/12/2563 BE.
//

import Foundation

// MARK: - TransactionsModel
public struct ProfileModel: Codable, Hashable {
    public let userID: String?

    enum CodingKeys: String, CodingKey {
        case userID = "userId"
    }

    public init(userID: String?) {
        self.userID = userID
    }
}
