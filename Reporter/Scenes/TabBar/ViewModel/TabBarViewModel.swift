//
//  TabBarViewModel.swift
//  Reporter
//
//  Created by Thatchaphon Sritrakul on 16/12/2563 BE.
//

import Foundation
import Combine
import Authentication
import Data

class TabBarViewModel: ObservableObject {
    private var subscriptions = Set<AnyCancellable>()
    
    init() {
        AuthenticationManager.shared.isLogin.sink { (reponse) in
            
        }.store(in: &self.subscriptions)
    }
    
    func fetchData() {
//        let coreDataProvider: CoreDataProvider<Profile> = CoreDataProvider<Profile>(coreDataName: .data)
//        coreDataProvider.fetch(Profile.self).sink { (error) in
//            print(error)
//        } receiveValue: { (response) in
//            print(response)
//        }.store(in: &self.subscriptions)

    }
}
