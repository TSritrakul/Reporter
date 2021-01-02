//
//  FirestoreRequestModel.swift
//  Core
//
//  Created by Thatchaphon Sritrakul on 2/1/2564 BE.
//

import Foundation

public struct FirestoreRequestModel {
    public let collection: String?
    public let document: String?
    
    public init(collection: String?, document: String?) {
        self.collection = collection
        self.document = document
    }
}
