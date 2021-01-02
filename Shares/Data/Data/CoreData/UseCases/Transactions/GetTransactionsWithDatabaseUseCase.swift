//
//  GetTransactionsUseCase.swift
//  Data
//
//  Created by Thatchaphon Sritrakul on 21/12/2563 BE.
//

import Foundation
import Combine

public enum GetTransactionsError: Error {
    case fetchError
    case notFoundElement
}

public protocol GetTransactionsWithDatabaseUseCase {
    func execute() -> AnyPublisher<TransactionsModel, GetTransactionsError>
}

public class GetTransactionsWithDatabaseUseCaseImpl: GetTransactionsWithDatabaseUseCase {
    public init() {}
    
    public func execute() -> AnyPublisher<TransactionsModel, GetTransactionsError> {
        let coreDataProvider: CoreDataProvider<Transactions> = CoreDataProvider<Transactions>(coreDataName: .data)
        return coreDataProvider.fetch(Transactions.self)
            .mapError { (error) -> GetTransactionsError in
                return .fetchError
            }.map({ (response) -> TransactionsModel in
                return response.map { (response) -> TransactionsModelElement in
                    return TransactionsModelElement(symbol: response.symbol,
                                             action: response.action,
                                             date: response.date,
                                             price: response.price,
                                             size: response.size,
                                             id: response.id,
                                             commission: response.commission,
                                             note: response.note)
                }
            })
            .eraseToAnyPublisher()
    }
}
