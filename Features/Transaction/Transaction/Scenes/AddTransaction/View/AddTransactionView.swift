//
//  AddTransactionView.swift
//  Transaction
//
//  Created by Thatchaphon Sritrakul on 19/12/2563 BE.
//

import SwiftUI

public struct AddTransactionView: View {
    @ObservedObject public var viewModel: AddTransactionViewModel
    
    public init(viewModel: AddTransactionViewModel) {
        self.viewModel = viewModel
    }
    
    public var body: some View {
        Text("Add Transaction")
    }
}

struct AddTransactionView_Previews: PreviewProvider {
    static var previews: some View {
        AddTransactionView(viewModel: AddTransactionViewModel())
    }
}
