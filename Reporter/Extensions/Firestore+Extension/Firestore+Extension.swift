//
//  Firestore+Extension.swift
//  Reporter
//
//  Created by Thatchaphon Sritrakul on 2/1/2564 BE.
//

import FirebaseFirestore
import Core
import Combine

extension Firestore: FirestoreType {
    public static func config() {
//        let settings = FirestoreSettings()
//        settings.isPersistenceEnabled = true
//        settings.cacheSizeBytes = FirestoreCacheSizeUnlimited
//        
//        let db = self.firestore()
//        db.settings = settings
    }
    
    public static func setData(context: [FirestoreRequestModel], data: [String : Any]) -> Future<Void, FirestoreError> {
        let documentReference = self.getDocumentReference(context: context)
        return Future { (promise) in
            documentReference.setData(data) { (error) in
                if let error = error {
                    promise(.failure(.setError(error: error)))
                }
            }
            promise(.success(Void()))
        }
    }
    
    public static func getData(context: [FirestoreRequestModel]) -> Future<[String:Any], FirestoreError> {
        let documentReference = self.getDocumentReference(context: context)
        return Future { (promise) in
            documentReference.getDocument { (documentSnapshot, error) in
                if let error = error {
                    promise(.failure(.getError(error: error)))
                } else {
                    if let querySnapshot = documentSnapshot {
                        let config = querySnapshot.data() ?? [:]
                        promise(.success(config))
                    }
                }
            }
        }
    }
    
    private static func getDocumentReference(context: [FirestoreRequestModel]) -> DocumentReference {
        let db = self.firestore()
        var ref: DocumentReference = db.collection(context[0].collection ?? "").document(context[0].document ?? "")
        if context.count > 1 {
            for index in 1..<context.count {
                ref = ref.collection(context[index].collection ?? "").document(context[index].document ?? "")
            }
        }
        return ref
    }
}
