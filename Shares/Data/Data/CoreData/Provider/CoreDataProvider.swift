//
//  CoreDataProvider.swift
//  Data
//
//  Created by Thatchaphon Sritrakul on 16/12/2563 BE.
//

import Foundation
import CoreData
import Combine

public enum CoreDataProviderError: Error {
    case saveError
    case fetchError
    case clearError
}

public class CoreDataProvider<T: NSManagedObject> {
    
    private var persistentContainer: NSPersistentContainer
    public lazy var context: NSManagedObjectContext = self.persistentContainer.viewContext
    
    public init(coreDataName: CoreDataName) {
        self.persistentContainer = CoreDataManager.shared.getPersistentContainer(coreDataType: coreDataName)
    }
    
    @discardableResult
    public func save(_ data: T) -> AnyPublisher<[T], CoreDataProviderError> {
        if self.context.hasChanges {
            do {
                try self.context.save()
                
            } catch {
                return Fail<[T], CoreDataProviderError>(error: .saveError)
                    .eraseToAnyPublisher()
            }
        }
        return self.fetch(T.self)
    }
    
    public func fetch(_ type: T.Type) -> AnyPublisher<[T], CoreDataProviderError> {
        return Future { (promise) in
            let request = NSFetchRequest<T>(entityName: String(describing: type))
            do {
                let object = try self.context.fetch(request)
                promise(.success(object))
            } catch {
                promise(.failure(.fetchError))
            }
        }
        .eraseToAnyPublisher()
    }
    
    @discardableResult
    public func clear(_ type: T.Type) -> AnyPublisher<Void, CoreDataProviderError> {
        return Future { (promise) in
            let request = NSFetchRequest<NSFetchRequestResult>(entityName: String(describing: T.self))
            let deleteRequest = NSBatchDeleteRequest(fetchRequest: request)
            do {
                try self.context.execute(deleteRequest)
                promise(.success(()))
            } catch {
                promise(.failure(.clearError))
            }
        }
        .eraseToAnyPublisher()
    }
}
