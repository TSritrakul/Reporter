//
//  AddTransactionViewModel.swift
//  Transaction
//
//  Created by Thatchaphon Sritrakul on 19/12/2563 BE.
//

import Foundation

public class AddTransactionViewModel: ObservableObject {
    @Published var symbol: String = ""
    @Published var action: String = "Buy"
    @Published var date: Date = Date()
    @Published var price: String = ""
    @Published var size: String = ""
    @Published var commission: String = ""
    
    public init() {}
}
