//
//  GetTransactionUseCase.swift
//  Data
//
//  Created by Thatchaphon Sritrakul on 26/12/2563 BE.
//

import Foundation
import Combine

public protocol GetTransactionsUseCase {
    func execute() -> CurrentValueSubject<TransactionsModel, Never>
}

public class GetTransactionsUseCaseImpl: GetTransactionsUseCase {
    public init() {}
    
    public func execute() -> CurrentValueSubject<TransactionsModel, Never> {
        return TransactionsManager.shared.transactions
    }
}
