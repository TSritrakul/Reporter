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
        NavigationView {
            Form {
                List {
                    HStack {
                        Text("Symbol")
                        TextField("Input Symbol", text: self.$viewModel.symbol)
                            .multilineTextAlignment(.trailing)
                    }
                    
                    Picker("Action", selection: self.$viewModel.action) {
                        Text("Buy").tag("Buy")
                        Text("Sell").tag("Sell")
                    }.pickerStyle(SegmentedPickerStyle())
                    
                    DatePicker("Date", selection: self.$viewModel.date)
                    HStack {
                        Text("Price")
                        TextField("Input Price", text: self.$viewModel.price)
                            .keyboardType(.numbersAndPunctuation)
                            .disableAutocorrection(true)
                            .multilineTextAlignment(.trailing)
                    }
                    HStack {
                        Text("Size")
                        TextField("Input Size", text: self.$viewModel.size)
                            .keyboardType(.numbersAndPunctuation)
                            .disableAutocorrection(true)
                            .multilineTextAlignment(.trailing)
                    }
                    HStack {
                        Text("Commission")
                        TextField("Input Commission", text: self.$viewModel.commission)
                            .keyboardType(.numbersAndPunctuation)
                            .disableAutocorrection(true)
                            .multilineTextAlignment(.trailing)
                    }
                }
            }
            .navigationBarTitle("Add Transaction", displayMode: .inline)
            .navigationBarItems(leading: Button("Cancel", action: {
                self.viewModel.selectedCancelButton()
            }), trailing: Button("Save", action: {
                
            }))
        }
        .navigationViewStyle(StackNavigationViewStyle())
    }
}
