//
//  DeleteTransactionUseCase.swift
//  Data
//
//  Created by Thatchaphon Sritrakul on 26/12/2563 BE.
//

import Foundation
import Combine

public protocol DeleteTransactionUseCase {
    func execute(transaction: TransactionsModelElement)
}

public class DeleteTransactionUseCaseImpl: DeleteTransactionUseCase {
    public init() {}
    
    public func execute(transaction: TransactionsModelElement) {
        return TransactionsManager.shared.deleteTransaction(transaction: transaction)
    }
}
