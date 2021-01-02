//
//  TransactionCellView.swift
//  Transaction
//
//  Created by Thatchaphon Sritrakul on 27/12/2563 BE.
//

import SwiftUI

struct TransactionCellView: View {
    @ObservedObject public var viewModel: TransactionCellViewModel
    
    init(viewModel: TransactionCellViewModel) {
        self.viewModel = viewModel
    }
    
    var body: some View {
        HStack(content: {
            Text("\(self.viewModel.transactions.symbol ?? "")")
                .frame(width: 60, alignment: .center)
                .lineLimit(1)
                .minimumScaleFactor(0.5)
            VStack(content: {
                HStack(content: {
                    Text("\(self.viewModel.changeDateFormat())")
                        .font(.caption)
                        .multilineTextAlignment(.leading)
                    Spacer()
                })
                HStack(content: {
                    Text("\(self.viewModel.transactions.action ?? "")")
                        .font(.caption)
                    Text("\(self.viewModel.transactions.price ?? "") x \(self.viewModel.transactions.size ?? "")")
                        .font(.caption)
                    Spacer()
                })
            })
        }).frame(height: 60, alignment: .center)
    }
}

struct TransactionCellView_Previews: PreviewProvider {
    static var previews: some View {
        TransactionCellView(viewModel: TransactionCellViewModel(transaction: .init(symbol: "PTT", action: "", date: Date(), price: "", size: "", id: UUID(), commission: "", note: "")))
    }
}
