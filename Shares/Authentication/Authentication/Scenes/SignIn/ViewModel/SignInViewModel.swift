//
//  SignInViewModel.swift
//  Authentication
//
//  Created by Thatchaphon Sritrakul on 17/12/2563 BE.
//

import Foundation
import Combine

public class SignInViewModel: ObservableObject {
    
    private var subscriptions: Set<AnyCancellable> = Set<AnyCancellable>()
    private let opener: ((AuthenticationOpener) -> Void)?
    
    public init(opener: ((AuthenticationOpener) -> Void)?) {
        self.opener = opener
    }
}
