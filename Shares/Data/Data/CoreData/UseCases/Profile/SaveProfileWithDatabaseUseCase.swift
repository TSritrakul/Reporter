//
//  SaveProfileUseCase.swift
//  Data
//
//  Created by Thatchaphon Sritrakul on 24/12/2563 BE.
//

import Foundation
import Combine

public enum SaveProfileError: Error {
    case userIdIsEmpty
    case saveError
    case clearError
}

public protocol SaveProfileWithDatabaseUseCase {
    @discardableResult
    func execute(profile: ProfileModel) -> AnyPublisher<Void, SaveProfileError>
}

public class SaveProfileWithDatabaseUseCaseImpl: SaveProfileWithDatabaseUseCase {
    public init() {}
    
    @discardableResult
    public func execute(profile: ProfileModel) -> AnyPublisher<Void, SaveProfileError> {
        let coreDataProvider: CoreDataProvider<Profile> = CoreDataProvider<Profile>(coreDataName: .data)
        let entity = Profile(context: coreDataProvider.context)
        entity.userID = profile.userID
        return coreDataProvider.clear(Profile.self).mapError({ (error) -> SaveProfileError in
            return .clearError
        }).flatMap { (_) -> AnyPublisher<Void, SaveProfileError> in
            return coreDataProvider.save().map { (response) -> Void in
                return Void()
            }.mapError { (errpr) -> SaveProfileError in
                return .saveError
            }.eraseToAnyPublisher()
        }.eraseToAnyPublisher()
    }
    
    private func validateProfile(profile: ProfileModel) -> Future<ProfileModel, SaveProfileError> {
        return Future { (promise) in
            if profile.userID == "" {
                promise(.failure(.userIdIsEmpty))
            }
            promise(.success(profile))
        }
    }
}
