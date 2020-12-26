//
//  TransactionViewModel.swift
//  Transaction
//
//  Created by Thatchaphon Sritrakul on 19/12/2563 BE.
//

import Foundation
import Data
import Combine

public class TransactionViewModel: ObservableObject {
    @Published var transactions: [TransactionsModel] = []
    
    private var subscriptions = Set<AnyCancellable>()
    
    public let opener: ((TransactionOpener) -> Void)?
    public let reloadTransactionsData: CurrentValueSubject<Void, Never>
    private let getTransactionsFromDatabaseUseCase: GetTransactionsFromDatabaseUseCase
    private let deleteTransactionsFromDatabaseUseCase: DeleteTransactionFromDatabaseUseCase
    
    public init(opener: ((TransactionOpener) -> Void)?,
                getTransactionsFromDatabaseUseCase: GetTransactionsFromDatabaseUseCase = GetTransactionsFromDatabaseUseCaseImpl(),
                deleteTransactionsFromDatabaseUseCase: DeleteTransactionFromDatabaseUseCase = DeleteTransactionFromDatabaseUseCaseImpl(),
                reloadTransactionsData: CurrentValueSubject<Void, Never> = CurrentValueSubject<Void, Never>(Void())) {
        self.opener = opener
        self.getTransactionsFromDatabaseUseCase = getTransactionsFromDatabaseUseCase
        self.deleteTransactionsFromDatabaseUseCase = deleteTransactionsFromDatabaseUseCase
        self.reloadTransactionsData = reloadTransactionsData
        
        self.reloadTransactionsData.sink { (_) in
            self.getTransactions()
        }.store(in: &self.subscriptions)
    }
    
    private func getTransactions() {
        self.getTransactionsFromDatabaseUseCase.execute().sink { (error) in
            switch error {
            case .finished:
                break
            case.failure(let error):
                print(error)
            }
        } receiveValue: { (response) in
            self.transactions = response
        }.store(in: &self.subscriptions)
    }
    
    public func deleteTransaction(index: IndexSet) {
        guard let index = Array(index).first else { return }
        self.deleteTransactionsFromDatabaseUseCase.execute(transaction: self.transactions[index]).mapError({ (error) -> GetTransactionsError in
            return .notFoundElement
        }).flatMap { (_) -> AnyPublisher<[TransactionsModel], GetTransactionsError> in
            return self.getTransactionsFromDatabaseUseCase.execute()
        }.sink { (error) in
            switch error {
            case .finished:
                break
            case.failure(let error):
                print(error)
            }
        } receiveValue: { (response) in
            self.transactions = response
        }.store(in: &self.subscriptions)
    }
}
