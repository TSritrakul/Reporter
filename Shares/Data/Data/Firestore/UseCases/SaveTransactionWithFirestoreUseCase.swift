//
//  SaveTransactionWithFirestoreUseCase.swift
//  Core
//
//  Created by Thatchaphon Sritrakul on 2/1/2564 BE.
//

import Foundation
import Combine
import Core

public protocol SaveTransactionWithFirestoreUseCase {
    func execute(data: String) -> AnyPublisher<Void, FirestoreError>
}

public class SaveTransactionWithFirestoreUseCaseImpl: SaveTransactionWithFirestoreUseCase {
    private let getProfileWithDatabaseUseCase: GetProfileWithDatabaseUseCase
    
    public init(getProfileWithDatabaseUseCase: GetProfileWithDatabaseUseCase = GetProfileWithDatabaseUseCaseImpl()) {
        self.getProfileWithDatabaseUseCase = getProfileWithDatabaseUseCase
    }
    
    public func execute(data: String) -> AnyPublisher<Void, FirestoreError> {
        return self.getProfileWithDatabaseUseCase.execute().mapError({ (error) -> FirestoreError in
            return .getError(error: error)
        }).flatMap { (profile) -> AnyPublisher<Void, FirestoreError> in
            if let profile = profile.last, let userID = profile.userID {
                return FirestoreManager.shared.setData(context: [.init(collection: "transaction", document: userID)], data: ["transaction": data])
                    .eraseToAnyPublisher()
            } else {
                return Fail<Void, FirestoreError>(error: .profileEmpty)
                    .eraseToAnyPublisher()
            }
        }.eraseToAnyPublisher()
    }
}
