//
//  TransactionCellViewModel.swift
//  Transaction
//
//  Created by Thatchaphon Sritrakul on 27/12/2563 BE.
//

import Foundation
import Data

class TransactionCellViewModel: ObservableObject {
    @Published var transactions: TransactionsModel
    
    init(transaction: TransactionsModel) {
        self.transactions = transaction
    }
    
    func changeDateFormat() -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "MMM dd, yyyy HH:mm:ss"
        return dateFormatter.string(from: self.transactions.date ?? Date())
    }
}
