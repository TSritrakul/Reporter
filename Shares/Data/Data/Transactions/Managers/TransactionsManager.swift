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
    
    var transactions: CurrentValueSubject = CurrentValueSubject<[TransactionsModel], Never>([])
    private var subscriptions = Set<AnyCancellable>()
    private let getTransactionsFromDatabaseUseCase: GetTransactionsFromDatabaseUseCase
    private let saveTransactionsFromDatabaseUseCase: SaveTransactionsFromDatabaseUseCase
    private let deleteTransactionsFromDatabaseUseCase: DeleteTransactionFromDatabaseUseCase
    
    
    init(getTransactionsFromDatabaseUseCase: GetTransactionsFromDatabaseUseCase = GetTransactionsFromDatabaseUseCaseImpl(),
         saveTransactionsFromDatabaseUseCase: SaveTransactionsFromDatabaseUseCase = SaveTransactionsFromDatabaseUseCaseImpl(),
         deleteTransactionsFromDatabaseUseCase: DeleteTransactionFromDatabaseUseCase = DeleteTransactionFromDatabaseUseCaseImpl()) {
        self.getTransactionsFromDatabaseUseCase = getTransactionsFromDatabaseUseCase
        self.saveTransactionsFromDatabaseUseCase = saveTransactionsFromDatabaseUseCase
        self.deleteTransactionsFromDatabaseUseCase = deleteTransactionsFromDatabaseUseCase
        
        self.getTransactions()
    }
    
    func getTransactions() {
        self.getTransactionsFromDatabaseUseCase.execute().sink { (error) in
            switch error {
            case .finished:
                break
            case .failure(let error):
                print(error)
            }
        } receiveValue: { (response) in
            self.transactions.send(response)
        }
        .store(in: &self.subscriptions)
    }
    
    func saveTransaction(transaction: TransactionsModel) {
        self.saveTransactionsFromDatabaseUseCase.execute(transaction: transaction).sink { (error) in
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
    
    func deleteTransaction(transaction: TransactionsModel) {
        self.deleteTransactionsFromDatabaseUseCase.execute(transaction: transaction).sink { (error) in
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
