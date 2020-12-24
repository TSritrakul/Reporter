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

public protocol SaveTransactionsUseCase {
    func execute(symbol: String,
                 action: String,
                 date: Date,
                 price: String,
                 size: String,
                 commission: String,
                 note: String) -> AnyPublisher<Void, SaveTransactionsError>
}

public class SaveTransactionsUseCaseImpl: SaveTransactionsUseCase {
    public init() {}
    
    public func execute(symbol: String,
                        action: String,
                        date: Date,
                        price: String,
                        size: String,
                        commission: String,
                        note: String) -> AnyPublisher<Void, SaveTransactionsError> {
        return self.validateTransaction(symbol: symbol,
                                        action: action,
                                        date: date,
                                        price: price,
                                        size: size,
                                        commission: commission,
                                        note: note)
            .flatMap { (response) -> AnyPublisher<Void, SaveTransactionsError> in
                let coreDataProvider: CoreDataProvider<Transactions> = CoreDataProvider<Transactions>(coreDataName: .data)
                let entity = Transactions(context: coreDataProvider.context)
                entity.symbol = symbol
                entity.action = action
                entity.date = date
                entity.price = price
                entity.size = size
                entity.commission = commission
                entity.note = note
                return  coreDataProvider.save(entity).map { (response) -> Void in
                    return Void()
                }
                .mapError { (error) -> SaveTransactionsError in
                    return .saveError
                }.eraseToAnyPublisher()
            }.eraseToAnyPublisher()
    }
    
    private func validateTransaction(symbol: String,
                                     action: String,
                                     date: Date,
                                     price: String,
                                     size: String,
                                     commission: String,
                                     note: String) -> AnyPublisher<(symbol: String,
                                                                    action: String,
                                                                    date: Date,
                                                                    price: String,
                                                                    size: String,
                                                                    commission: String,
                                                                    note: String),
                                                                   SaveTransactionsError> {
        return Future { (promise) in
            if symbol.isEmpty {
                promise(.failure(.symbolIsEmpty))
            } else if price.isEmpty {
                promise(.failure(.priceIsEmptry))
            } else if size.isEmpty {
                promise(.failure(.sizeIsEmptry))
            } else if commission.isEmpty {
                promise(.failure(.commissionIsEmptry))
            }
            
            promise(.success((symbol: "String",
                              action: "String",
                              date: Date(),
                              price: "String",
                              size: "String",
                              commission: "String",
                              note: "String")))
        }
        .eraseToAnyPublisher()
    }
}
