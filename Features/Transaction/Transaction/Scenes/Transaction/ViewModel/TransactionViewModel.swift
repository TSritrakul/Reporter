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
    @Published var transactions: TransactionsModel = []
    
    private var subscriptions = Set<AnyCancellable>()
    
    public let opener: ((TransactionOpener) -> Void)?
    public let reloadTransactionsData: CurrentValueSubject<Void, Never>
    private let getTransactionsUseCase: GetTransactionsUseCase
    private let deleteTransactionUseCase: DeleteTransactionUseCase
    
    public init(opener: ((TransactionOpener) -> Void)?,
                getTransactionsUseCase: GetTransactionsUseCase = GetTransactionsUseCaseImpl(),
                deleteTransactionUseCase: DeleteTransactionUseCase = DeleteTransactionUseCaseImpl(),
                reloadTransactionsData: CurrentValueSubject<Void, Never> = CurrentValueSubject<Void, Never>(Void())) {
        self.opener = opener
        self.getTransactionsUseCase = getTransactionsUseCase
        self.deleteTransactionUseCase = deleteTransactionUseCase
        self.reloadTransactionsData = reloadTransactionsData
        
        self.reloadTransactionsData.sink { (_) in
            self.getTransactions()
        }.store(in: &self.subscriptions)
    }
    
    private func getTransactions() {
        self.getTransactionsUseCase.execute().sink(receiveValue: { (response) in
            self.transactions = response
        }).store(in: &self.subscriptions)
    }
    
    public func deleteTransaction(index: IndexSet) {
        guard let index = Array(index).first else { return }
        self.deleteTransactionUseCase.execute(transaction: self.transactions[index])
    }
}
