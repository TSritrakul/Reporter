//
//  TransactionOpener.swift
//  Transaction
//
//  Created by Thatchaphon Sritrakul on 19/12/2563 BE.
//

import Foundation
import Combine

public enum TransactionOpener {
    case addTransaction(reloadTransactionsData: CurrentValueSubject<Void, Never>)
    case dismiss
}
