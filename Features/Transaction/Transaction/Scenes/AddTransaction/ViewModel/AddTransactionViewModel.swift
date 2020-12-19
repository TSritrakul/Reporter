//
//  AddTransactionViewModel.swift
//  Transaction
//
//  Created by Thatchaphon Sritrakul on 19/12/2563 BE.
//

import Foundation
import Combine

public class AddTransactionViewModel: ObservableObject {
    private var subscriptions = Set<AnyCancellable>()
    
    @Published var symbol: String = ""
    @Published var action: String = "Buy"
    @Published var date: Date = Date()
    @Published var price: String = ""
    @Published var size: String = ""
    @Published var commission: String = ""
    
    public let opener: ((TransactionOpener) -> Void)?
    
    public init(opener: ((TransactionOpener) -> Void)?) {
        self.opener = opener
    }
    
    func selectedCancelButton() {
        self.opener?(.dismiss)
    }
    
    func selectedSaveButton() {
        
    }
}
