//
//  AddTransactionButtonView.swift
//  Transaction
//
//  Created by Thatchaphon Sritrakul on 19/12/2563 BE.
//

import SwiftUI

struct AddTransactionButtonView: View {
    @ObservedObject public var viewModel: TransactionViewModel
    
    var body: some View {
        VStack {
            Spacer()
            HStack {
                Spacer()
                Circle()
                    .fill(Color.yellow)
                    .shadow(radius: 5)
                    .frame(width: 60, height: 60, alignment: .center)
                    .onTapGesture {
                        self.viewModel.selectedAddTransactionButton()
                    }
                Spacer().frame(width: 20)
            }
            Spacer().frame(height: 20)
        }
    }
}

//struct AddTransactionButtonView_Previews: PreviewProvider {
//    static var previews: some View {
//        AddTransactionButtonView()
//    }
//}
