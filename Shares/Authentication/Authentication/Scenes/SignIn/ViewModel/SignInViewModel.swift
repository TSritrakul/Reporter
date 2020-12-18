//
//  SignInViewModel.swift
//  Authentication
//
//  Created by Thatchaphon Sritrakul on 17/12/2563 BE.
//

import Foundation
import Combine

public class SignInViewModel: ObservableObject {
    
    @Published public var isLogin: Bool = false
    private var subscriptions: Set<AnyCancellable> = Set<AnyCancellable>()
    private let opener: ((AuthenticationOpener) -> Void)?
    
    public init(opener: ((AuthenticationOpener) -> Void)?) {
        self.opener = opener
        
        GoogleSignInManager.shared.isLogin.sink { [weak self] (response) in
            guard let self = self else { return }
            self.isLogin = response
            if response {
                self.opener?(.loginSuccess)
            }
        }.store(in: &self.subscriptions)
    }
}
