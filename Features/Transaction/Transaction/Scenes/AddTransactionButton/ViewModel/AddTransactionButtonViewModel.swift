//
//  AddTransactionButtonViewModel.swift
//  Transaction
//
//  Created by Thatchaphon Sritrakul on 19/12/2563 BE.
//

import Foundation
import Combine

public class AddTransactionButtonViewModel: ObservableObject {
    private let opener: ((TransactionOpener) -> Void)?
    public let reloadTransactionsData: CurrentValueSubject<Void, Never>
    
    public init(opener: ((TransactionOpener) -> Void)?,
                reloadTransactionsData: CurrentValueSubject<Void, Never>) {
        self.opener = opener
        self.reloadTransactionsData = reloadTransactionsData
    }
    
    public func selectedAddTransactionButton() {
        self.opener?(.addTransaction(reloadTransactionsData: reloadTransactionsData))
    }
}
