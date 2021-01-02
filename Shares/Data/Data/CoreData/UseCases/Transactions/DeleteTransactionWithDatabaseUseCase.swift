//
//  DeleteTransactionUseCase.swift
//  Data
//
//  Created by Thatchaphon Sritrakul on 26/12/2563 BE.
//

import Foundation
import Combine

public enum DeleteTransactionError: Error {
    case fetchError
    case saveError
    case notFoundElement
}

public protocol DeleteTransactionWithDatabaseUseCase {
    func execute(transaction: TransactionsModelElement) -> AnyPublisher<Void, DeleteTransactionError>
}

public class DeleteTransactionWithDatabaseUseCaseImpl: DeleteTransactionWithDatabaseUseCase {
    public init() {}
    
    public func execute(transaction: TransactionsModelElement) -> AnyPublisher<Void, DeleteTransactionError> {
        
        let coreDataProvider: CoreDataProvider<Transactions> = CoreDataProvider<Transactions>(coreDataName: .data)
        
        return coreDataProvider.fetch(Transactions.self)
            .mapError({ (error) -> DeleteTransactionError in
                return .fetchError
            })
            .flatMap { (response) -> AnyPublisher<Void, DeleteTransactionError> in
                let index = response.firstIndex { (response) -> Bool in
                    return response.id == transaction.id
                }
                if let index = index {
                    coreDataProvider.context.delete(response[index])
                    return coreDataProvider.save().map { (response) -> Void in
                        return Void()
                    }
                    .mapError { (error) -> DeleteTransactionError in
                        return .saveError
                    }.eraseToAnyPublisher()
                } else {
                    return Fail<Void, DeleteTransactionError>(error: .notFoundElement)
                        .eraseToAnyPublisher()
                }
            }.eraseToAnyPublisher()
    }
}
