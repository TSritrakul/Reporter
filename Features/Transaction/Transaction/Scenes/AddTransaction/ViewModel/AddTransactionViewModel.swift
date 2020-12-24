//
//  AddTransactionViewModel.swift
//  Transaction
//
//  Created by Thatchaphon Sritrakul on 19/12/2563 BE.
//

import Foundation
import Combine
import Data
import CoreData

public class AddTransactionViewModel: ObservableObject {
    private var subscriptions = Set<AnyCancellable>()
    
    @Published var symbol: String = ""
    @Published var action: String = "Buy"
    @Published var date: Date = Date()
    @Published var price: String = ""
    @Published var size: String = ""
    @Published var commission: String = ""
    @Published var note: String = ""
    
    private let saveTransactionsUseCase: SaveTransactionsUseCase
    
    public let opener: ((TransactionOpener) -> Void)?
    
    public init(opener: ((TransactionOpener) -> Void)?,
                saveTransactionsUseCase: SaveTransactionsUseCase = SaveTransactionsUseCaseImpl()) {
        self.opener = opener
        self.saveTransactionsUseCase = saveTransactionsUseCase

//        self.selectedSaveButton.flatMap { [weak self] (_) -> AnyPublisher<Void, SaveTransactionsError> in
//            guard let self = self else { return Fail<Void, SaveTransactionsError>(error: .weakSelfError).eraseToAnyPublisher() }
//            return self.saveTransactionsUseCase.execute(symbol: self.symbol,
//                                                        action: self.action,
//                                                        date: self.date,
//                                                        price: self.price,
//                                                        size: self.size,
//                                                        commission: self.commission,
//                                                        note: self.note)
//        }.sink { (error) in
//            print(error)
//        } receiveValue: { (_) in
//            print("SS")
////            self.opener?(.dismiss)
//        }.store(in: &self.subscriptions)

    }
    
    func selectedCancelButton() {
        
        let coreDataProvider: CoreDataProvider<Transactions> = CoreDataProvider<Transactions>(coreDataName: .data)
        
        coreDataProvider.fetch(Transactions.self).sink { (error) in
//            print(error)
        } receiveValue: { (response) in
            for x in response {
                print(x.symbol)
            }
            if let first = response.first {
                print("Delete: \(first)")
//                coreDataProvider.context.delete(first)
            }
        }.store(in: &self.subscriptions)

//        self.opener?(.dismiss)
    }
    
    func selectedSaveButton() {
        self.saveTransactionsUseCase.execute(symbol: self.symbol,
                                                    action: self.action,
                                                    date: self.date,
                                                    price: self.price,
                                                    size: self.size,
                                                    commission: self.commission,
                                                    note: self.note)
            .sink { (error) in
                print(error)
            } receiveValue: { (response) in
                print("Success")
            }
            .store(in: &self.subscriptions)
    }
}
