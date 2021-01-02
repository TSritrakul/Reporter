//
//  TransactionModel.swift
//  Data
//
//  Created by Thatchaphon Sritrakul on 25/12/2563 BE.
//

import Foundation

// MARK: - TransactionsModel
public struct TransactionsModelElement: Codable, Identifiable {
    public let symbol: String?
    public let action: String?
    public let date: Date?
    public let price: String?
    public let size: String?
    public let id: UUID?
    public let commission: String?
    public let note: String?

    enum CodingKeys: String, CodingKey {
        case symbol = "symbol"
        case action = "action"
        case date = "date"
        case price = "price"
        case size = "size"
        case id = "id"
        case commission = "commission"
        case note = "note"
    }

    public init(symbol: String?, action: String?, date: Date?, price: String?, size: String?, id: UUID?, commission: String?, note: String?) {
        self.symbol = symbol
        self.action = action
        self.date = date
        self.price = price
        self.size = size
        self.id = id
        self.commission = commission
        self.note = note
    }
}

public typealias TransactionsModel = [TransactionsModelElement]
