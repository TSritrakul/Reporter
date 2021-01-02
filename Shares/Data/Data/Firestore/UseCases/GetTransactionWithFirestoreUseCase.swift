//
//  GetTransactionWithFirestoreUseCase.swift
//  Data
//
//  Created by Thatchaphon Sritrakul on 3/1/2564 BE.
//

import Foundation
import Combine
import Core

public protocol GetTransactionWithFirestoreUseCase {
    func execute() -> AnyPublisher<TransactionsModel, FirestoreError>
}

public class GetTransactionWithFirestoreUseCaseImpl: GetTransactionWithFirestoreUseCase {
    private let getProfileWithDatabaseUseCase: GetProfileWithDatabaseUseCase
    
    public init(getProfileWithDatabaseUseCase: GetProfileWithDatabaseUseCase = GetProfileWithDatabaseUseCaseImpl()) {
        self.getProfileWithDatabaseUseCase = getProfileWithDatabaseUseCase
    }
    
    public func execute() -> AnyPublisher<TransactionsModel, FirestoreError> {
        return self.getProfileWithDatabaseUseCase.execute().mapError({ (error) -> FirestoreError in
            return .getError(error: error)
        }).flatMap { (profile) -> AnyPublisher<[String: Any], FirestoreError> in
            if let profile = profile.last, let userID = profile.userID {
                return FirestoreManager.shared.getData(context: [.init(collection: "transaction", document: userID)]).eraseToAnyPublisher()
            } else {
                return Fail<[String: Any], FirestoreError>(error: .profileEmpty)
                    .eraseToAnyPublisher()
            }
        }.map { (response) -> TransactionsModel in
            let decoder = JSONDecoder()
            if let jsonString: String = response["transaction"] as? String, let jsonData = jsonString.data(using: .utf8), let transaction = try? decoder.decode(TransactionsModel.self, from: jsonData) {
                return transaction
            } else {
                return TransactionsModel()
            }
        }.eraseToAnyPublisher()
    }
}
