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
                VStack {
                    Spacer()
                    HStack {
                        Spacer()
                        Circle()
                            .fill(Color.yellow)
                            .shadow(radius: 5)
                            .frame(width: 60, height: 60, alignment: .center)
                        Spacer().frame(width: 20)
                    }
                    Spacer().frame(height: 20)
                }
            }
            .navigationBarTitle("Transaction")
        }
    }
}

//struct TransactionView_Previews: PreviewProvider {
//    static var previews: some View {
//        TransactionView(viewModel: TransactionViewModel())
//    }
//}
