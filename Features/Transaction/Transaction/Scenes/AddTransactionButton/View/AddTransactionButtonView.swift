//
//  AddTransactionButtonView.swift
//  Transaction
//
//  Created by Thatchaphon Sritrakul on 19/12/2563 BE.
//

import SwiftUI

public struct AddTransactionButtonView: View {
    @ObservedObject public var viewModel: AddTransactionButtonViewModel
    
    public init(viewModel: AddTransactionButtonViewModel) {
        self.viewModel = viewModel
    }
    
    public var body: some View {
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
