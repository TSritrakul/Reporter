//
//  MainViewModel.swift
//  Reporter
//
//  Created by Thatchaphon Sritrakul on 18/12/2563 BE.
//

import Foundation
import Combine
import Authentication

class MainViewModel: ObservableObject {
    private var subscriptions = Set<AnyCancellable>()
    @Published var isLogin: Bool = false
    
    init() {
        AuthenticationManager.shared.isLogin.sink { [weak self] (reponse) in
            guard let self = self else { return }
            self.isLogin = reponse
        }.store(in: &self.subscriptions)
    }
}
