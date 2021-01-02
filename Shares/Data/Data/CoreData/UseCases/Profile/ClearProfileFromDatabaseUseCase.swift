//
//  ClearProfileFromDatabaseUseCase.swift
//  Data
//
//  Created by Thatchaphon Sritrakul on 2/1/2564 BE.
//

import Foundation
import Combine

public enum ClearProfileError: Error {
    case clearError
}

public protocol ClearProfileFromDatabaseUseCase {
    @discardableResult
    func execute() -> AnyPublisher<Void, ClearProfileError>
}

public class ClearProfileFromDatabaseUseCaseImpl: ClearProfileFromDatabaseUseCase {
    
    public init() {}
    
    public func execute() -> AnyPublisher<Void, ClearProfileError> {
        let coreDataProvider: CoreDataProvider<Profile> = CoreDataProvider<Profile>(coreDataName: .data)
        return coreDataProvider.clear(Profile.self).mapError { (error) -> ClearProfileError in
            return .clearError
        }.eraseToAnyPublisher()
    }
}
