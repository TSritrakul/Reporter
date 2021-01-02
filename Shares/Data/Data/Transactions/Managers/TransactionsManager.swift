//
//  TransactionsManager.swift
//  Data
//
//  Created by Thatchaphon Sritrakul on 26/12/2563 BE.
//

import Foundation
import Combine

class TransactionsManager {
    static let shared: TransactionsManager = TransactionsManager()
    
    var transactions: CurrentValueSubject = CurrentValueSubject<TransactionsModel, Never>([])
    private var subscriptions = Set<AnyCancellable>()
    private let getTransactionsWithDatabaseUseCase: GetTransactionsWithDatabaseUseCase
    private let saveTransactionsWithDatabaseUseCase: SaveTransactionsWithDatabaseUseCase
    private let deleteTransactionsWithDatabaseUseCase: DeleteTransactionWithDatabaseUseCase
    private let saveTransactionWithFirestoreUseCase: SaveTransactionWithFirestoreUseCase
    private let getTransactionWithFirestoreUseCase: GetTransactionWithFirestoreUseCase
    
    
    init(getTransactionsWithDatabaseUseCase: GetTransactionsWithDatabaseUseCase = GetTransactionsWithDatabaseUseCaseImpl(),
         saveTransactionsWithDatabaseUseCase: SaveTransactionsWithDatabaseUseCase = SaveTransactionsWithDatabaseUseCaseImpl(),
         deleteTransactionsWithDatabaseUseCase: DeleteTransactionWithDatabaseUseCase = DeleteTransactionWithDatabaseUseCaseImpl(),
         saveTransactionWithFirestoreUseCase: SaveTransactionWithFirestoreUseCase = SaveTransactionWithFirestoreUseCaseImpl(),
         getTransactionWithFirestoreUseCase: GetTransactionWithFirestoreUseCase = GetTransactionWithFirestoreUseCaseImpl()) {
        self.getTransactionsWithDatabaseUseCase = getTransactionsWithDatabaseUseCase
        self.saveTransactionsWithDatabaseUseCase = saveTransactionsWithDatabaseUseCase
        self.deleteTransactionsWithDatabaseUseCase = deleteTransactionsWithDatabaseUseCase
        self.saveTransactionWithFirestoreUseCase = saveTransactionWithFirestoreUseCase
        self.getTransactionWithFirestoreUseCase = getTransactionWithFirestoreUseCase
        
        self.getTransactions()
    }
    
    func getTransactions() {
        self.getTransactionsWithDatabaseUseCase.execute().sink { (error) in
            switch error {
            case .finished:
                break
            case .failure(let error):
                print(error)
            }
        } receiveValue: { (response) in
            let response = response.sorted { (first, second) -> Bool in
                return first.date ?? Date() > second.date ?? Date()
            }
            if response.isEmpty {
                self.getTransactionWithFirestore()
            } else {
                self.transactions.send(response)
                self.saveTransactionWithFirestore()
            }
        }
        .store(in: &self.subscriptions)
    }
    
    func saveTransaction(transaction: TransactionsModelElement) {
        self.saveTransactionsWithDatabaseUseCase.execute(transaction: transaction).sink { (error) in
            switch error {
            case .finished:
                break
            case .failure(let error):
                print(error)
            }
        } receiveValue: { (_) in
            self.getTransactions()
        }.store(in: &self.subscriptions)
    }
    
    func saveTransactionWithFirestore() {
        if let jsonData = try? JSONEncoder().encode(self.transactions.value), let jsonString = String(data: jsonData, encoding: .utf8) {
            self.saveTransactionWithFirestoreUseCase.execute(data: jsonString).sink { (error) in
                switch error {
                case .finished:
                    break
                case .failure(let error):
                    print(error)
                }
            } receiveValue: { (_) in
                print("Success")
            }.store(in: &self.subscriptions)
        }
    }
    
    func getTransactionWithFirestore() {
        self.getTransactionWithFirestoreUseCase.execute().sink { (error) in
            switch error {
            case .finished:
                break
            case .failure(let error):
                print(error)
            }
        } receiveValue: { (response) in
            self.transactions.send(response)
        }.store(in: &self.subscriptions)
    }
    
    func deleteTransaction(transaction: TransactionsModelElement) {
        self.deleteTransactionsWithDatabaseUseCase.execute(transaction: transaction).sink { (error) in
            switch error {
            case .finished:
                break
            case .failure(let error):
                print(error)
            }
        } receiveValue: { (_) in
            self.getTransactions()
        }.store(in: &self.subscriptions)
    }
}
