//
//  AddTransactionViewModel.swift
//  Transaction
//
//  Created by Thatchaphon Sritrakul on 19/12/2563 BE.
//

import Foundation
import Combine
import Data
import CoreData

public class AddTransactionViewModel: ObservableObject {
    private var subscriptions = Set<AnyCancellable>()
    
    @Published var symbol: String = ""
    @Published var action: String = "Buy"
    @Published var date: Date = Date()
    @Published var price: String = ""
    @Published var size: String = ""
    @Published var commission: String = ""
    @Published var note: String = ""
    
    private let saveTransactionsUseCase: SaveTransactionsUseCase
    
    public let opener: ((TransactionOpener) -> Void)?
    public let reloadTransactionsData: CurrentValueSubject<Void, Never>
    
    public init(opener: ((TransactionOpener) -> Void)?,
                saveTransactionsUseCase: SaveTransactionsUseCase = SaveTransactionsUseCaseImpl(),
                reloadTransactionsData: CurrentValueSubject<Void, Never>) {
        self.opener = opener
        self.saveTransactionsUseCase = saveTransactionsUseCase
        self.reloadTransactionsData = reloadTransactionsData
    }
    
    func selectedCancelButton() {
        self.opener?(.dismiss)
    }
    
    func selectedSaveButton() {
        let transaction: TransactionsModel = TransactionsModel(symbol: symbol,
                                                               action: action,
                                                               date: date,
                                                               price: price,
                                                               size: size,
                                                               id: UUID(),
                                                               commission: commission,
                                                               note: note)
        self.saveTransactionsUseCase.execute(transaction: transaction)
            .sink { (error) in
                switch error {
                case .finished:
                    break
                case .failure(let error):
                    print(error)
                }
            } receiveValue: { (response) in
                self.reloadTransactionsData.send(Void())
                self.opener?(.dismiss)
            }
            .store(in: &self.subscriptions)
    }
}
