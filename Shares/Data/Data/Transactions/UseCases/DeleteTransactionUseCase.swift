//
//  DeleteTransactionUseCase.swift
//  Data
//
//  Created by Thatchaphon Sritrakul on 26/12/2563 BE.
//

import Foundation
import Combine

public protocol DeleteTransactionUseCase {
    func execute(transaction: TransactionsModel)
}

public class DeleteTransactionUseCaseImpl: DeleteTransactionUseCase {
    public init() {}
    
    public func execute(transaction: TransactionsModel) {
        return TransactionsManager.shared.deleteTransaction(transaction: transaction)
    }
}
