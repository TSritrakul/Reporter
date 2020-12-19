//
//  AddTransactionButtonViewModel.swift
//  Transaction
//
//  Created by Thatchaphon Sritrakul on 19/12/2563 BE.
//

import Foundation

public class AddTransactionButtonViewModel: ObservableObject {
    private let opener: ((TransactionOpener) -> Void)?
    
    public init(opener: ((TransactionOpener) -> Void)?) {
        self.opener = opener
    }
    
    public func selectedAddTransactionButton() {
        self.opener?(.addTransaction)
    }
}
