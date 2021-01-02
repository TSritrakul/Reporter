//
//  SaveTransactionUseCase.swift
//  Data
//
//  Created by Thatchaphon Sritrakul on 26/12/2563 BE.
//

import Foundation
import Combine

public protocol SaveTransactionUseCase {
    func execute(transaction: TransactionsModelElement)
}

public class SaveTransactionUseCaseImpl: SaveTransactionUseCase {
    public init() {}
    
    public func execute(transaction: TransactionsModelElement) {
        return TransactionsManager.shared.saveTransaction(transaction: transaction)
    }
}
