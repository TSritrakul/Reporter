//
//  TransactionView.swift
//  Transaction
//
//  Created by Thatchaphon Sritrakul on 19/12/2563 BE.
//

import SwiftUI

public struct TransactionView: View {
    @ObservedObject public var viewModel: TransactionViewModel
    
    public init(viewModel: TransactionViewModel) {
        self.viewModel = viewModel
    }
    
    public var body: some View {
        NavigationView {
            ZStack {
                List {
                    if self.viewModel.transactions.count > 0 {
                        ForEach(self.viewModel.transactions, id: \.id) { (response) in
                            TransactionCellView(viewModel: TransactionCellViewModel(transaction: response))
                        }
                        .onDelete { (index) in
                            self.viewModel.deleteTransaction(index: index)
                        }
                    } else {
                        Text("Please add transaction.")
                    }
                }
                AddTransactionButtonView(viewModel: AddTransactionButtonViewModel(opener: self.viewModel.opener, reloadTransactionsData: self.viewModel.reloadTransactionsData))
            }
            .navigationBarTitle("Transaction")
        }
        .navigationViewStyle(StackNavigationViewStyle())
    }
}
