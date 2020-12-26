//
//  GetProfileUseCase.swift
//  Data
//
//  Created by Thatchaphon Sritrakul on 25/12/2563 BE.
//

import Foundation
import Combine

public enum GetProfileError: Error {
    case fetchError
}

public protocol GetProfileFromDatabaseUseCase {
    func execute() -> AnyPublisher<[Profile], GetProfileError>
}

public class GetProfileFromDatabaseUseCaseImpl: GetProfileFromDatabaseUseCase {
    public init() {}
    
    public func execute() -> AnyPublisher<[Profile], GetProfileError> {
        let coreDataProvider: CoreDataProvider<Profile> = CoreDataProvider<Profile>(coreDataName: .data)
        return coreDataProvider.fetch(Profile.self)
            .mapError { (error) -> GetProfileError in
                return .fetchError
            }
            .eraseToAnyPublisher()
    }
}
