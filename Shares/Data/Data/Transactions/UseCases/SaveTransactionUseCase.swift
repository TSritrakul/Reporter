//
//  SaveTransactionUseCase.swift
//  Data
//
//  Created by Thatchaphon Sritrakul on 26/12/2563 BE.
//

import Foundation
import Combine

public protocol SaveTransactionUseCase {
    func execute(transaction: TransactionsModel)
}

public class SaveTransactionUseCaseImpl: SaveTransactionUseCase {
    public init() {}
    
    public func execute(transaction: TransactionsModel) {
        return TransactionsManager.shared.saveTransaction(transaction: transaction)
    }
}
