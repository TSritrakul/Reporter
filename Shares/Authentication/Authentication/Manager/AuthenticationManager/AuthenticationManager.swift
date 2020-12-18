//
//  AuthenticationManager.swift
//  Authentication
//
//  Created by Thatchaphon Sritrakul on 14/12/2563 BE.
//

import Foundation
import Combine

public class AuthenticationManager {
    
    public static let shared: AuthenticationManager = AuthenticationManager()
    private var authenticationType: AuthenticationType.Type!
    private var subscriptions = Set<AnyCancellable>()
    
    public var isLogin = CurrentValueSubject<Bool, Never>(false)
    
    private init() {}
    
    public func configAuthentication(_ authenticationType: AuthenticationType.Type) {
        self.authenticationType = authenticationType
        
        self.authenticationType.isLogin.sink { (response) in
            self.isLogin.send(response)
        }
        .store(in: &self.subscriptions)
        
        self.authenticationType.config()
    }
    
    public func signIn() {
        self.authenticationType.signIn()
    }
    
    public func signOut() {
        self.authenticationType.signOut()
    }
}
