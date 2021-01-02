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
    
    private let saveTransactionUseCase: SaveTransactionUseCase
    
    public let opener: ((TransactionOpener) -> Void)?
    
    public init(opener: ((TransactionOpener) -> Void)?,
                saveTransactionUseCase: SaveTransactionUseCase = SaveTransactionUseCaseImpl()) {
        self.opener = opener
        self.saveTransactionUseCase = saveTransactionUseCase
    }
    
    func selectedCancelButton() {
        self.opener?(.dismiss)
    }
    
    func selectedSaveButton() {
        let transaction: TransactionsModelElement = TransactionsModelElement(symbol: symbol,
                                                               action: action,
                                                               date: date,
                                                               price: price,
                                                               size: size,
                                                               id: UUID(),
                                                               commission: commission,
                                                               note: note)
        
        if transaction.symbol == "" {
            print("symbolIsEmpty")
        } else if transaction.price == "" {
            print("priceIsEmptry")
        } else if transaction.size == "" {
            print("sizeIsEmptry")
        } else if transaction.commission == "" {
            print("commissionIsEmptry")
        } else {
            self.saveTransactionUseCase.execute(transaction: transaction)
            self.opener?(.dismiss)
        }
    }
}
