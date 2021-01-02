//
//  SaveTransactionsUseCase.swift
//  Data
//
//  Created by Thatchaphon Sritrakul on 21/12/2563 BE.
//

import Foundation
import Combine

public enum SaveTransactionsError: Error {
    case symbolIsEmpty
    case priceIsEmptry
    case sizeIsEmptry
    case commissionIsEmptry
    case saveError
    case weakSelfError
}

public protocol SaveTransactionsWithDatabaseUseCase {
    func execute(transaction: TransactionsModelElement) -> AnyPublisher<Void, SaveTransactionsError>
}

public class SaveTransactionsWithDatabaseUseCaseImpl: SaveTransactionsWithDatabaseUseCase {
    public init() {}
    
    public func execute(transaction: TransactionsModelElement) -> AnyPublisher<Void, SaveTransactionsError> {
        return self.validateTransaction(transaction: transaction)
            .flatMap { (response) -> AnyPublisher<Void, SaveTransactionsError> in
                let coreDataProvider: CoreDataProvider<Transactions> = CoreDataProvider<Transactions>(coreDataName: .data)
                let entity = Transactions(context: coreDataProvider.context)
                entity.symbol = transaction.symbol
                entity.action = transaction.action
                entity.date = transaction.date
                entity.price = transaction.price
                entity.size = transaction.size
                entity.commission = transaction.commission
                entity.note = transaction.note
                entity.id = transaction.id
                return  coreDataProvider.save().map { (response) -> Void in
                    return Void()
                }
                .mapError { (error) -> SaveTransactionsError in
                    return .saveError
                }.eraseToAnyPublisher()
            }.eraseToAnyPublisher()
    }
    
    private func validateTransaction(transaction: TransactionsModelElement) -> Future<TransactionsModelElement, SaveTransactionsError> {
        return Future { (promise) in
            
            if transaction.symbol == "" {
                promise(.failure(.symbolIsEmpty))
            } else if transaction.price == "" {
                promise(.failure(.priceIsEmptry))
            } else if transaction.size == "" {
                promise(.failure(.sizeIsEmptry))
            } else if transaction.commission == "" {
                promise(.failure(.commissionIsEmptry))
            }
            
            promise(.success(transaction))
        }
    }
}
