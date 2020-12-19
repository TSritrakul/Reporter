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
                Text("TransactionView")
                    .onTapGesture {
                        print("Touch")
                    }
                AddTransactionButtonView(viewModel: AddTransactionButtonViewModel(opener: self.viewModel.opener))
            }
            .navigationBarTitle("Transaction")
        }
        .navigationViewStyle(StackNavigationViewStyle())
    }
}
