//
//  FirestoreManager.swift
//  Core
//
//  Created by Thatchaphon Sritrakul on 2/1/2564 BE.
//

import Foundation
import Combine

public enum FirestoreError: Error {
    case setError(error: Error)
    case getError(error: Error)
    case profileEmpty
}

public protocol FirestoreType {
    static func setData(context: [FirestoreRequestModel], data: [String : Any]) -> Future<Void, FirestoreError>
    
    static func updateData(context: [FirestoreRequestModel], data: [String : Any]) -> Future<Void, FirestoreError>
    
    static func getData(context: [FirestoreRequestModel]) -> Future<[String:Any], FirestoreError>
    
    static func config()
}

public class FirestoreManager {
    public static let shared: FirestoreManager = FirestoreManager()
    private var firestoreConfig: FirestoreType.Type!
    
    private init() {}
    
    public func configFirestore(_ firestoreConfig: FirestoreType.Type) {
        self.firestoreConfig = firestoreConfig
        self.firestoreConfig.config()
    }
    
    /// Use for satting data to Firestore.
    ///
    /// For example:
    ///
    ///     let context: [FirestoreRequestModel] = [FirestoreRequestModel(collection: "concurrency", document: "LA")]
    ///     let data: [String : Any] = ["nickName" : "Phat"]
    ///     FirestoreManager.shared.setData(context: context, data: data) { (error) in
    ///         print(error)
    ///     }
    
    public func setData(context: [FirestoreRequestModel], data: [String : Any]) -> Future<Void, FirestoreError> {
        return self.firestoreConfig.setData(context: context, data: data)
    }
    
    public func updateData(context: [FirestoreRequestModel], data: [String : Any]) -> Future<Void, FirestoreError> {
        return self.firestoreConfig.updateData(context: context, data: data)
    }
    
    /// Use for fetching data from Firestore.
    ///
    /// For example:
    ///
    ///     let context: [FirestoreRequestModel] = [FirestoreRequestModel(collection: "concurrency", document: "LA")]
    ///     FirestoreManager.shared.getData(context: context) { (data, error) in
    ///         print(data)
    ///         print(error)
    ///     }
    
    public func getData(context: [FirestoreRequestModel]) -> Future<[String:Any], FirestoreError> {
        return self.firestoreConfig.getData(context: context)
    }
}
