//
//  GoogleSignInManager.swift
//  Authentication
//
//  Created by Thatchaphon Sritrakul on 14/12/2563 BE.
//

import Foundation
import Combine

public class GoogleSignInManager {
    
    public static let shared: GoogleSignInManager = GoogleSignInManager()
    private var googleSignInType: GoogleSignInType.Type!
    private var subscriptions = Set<AnyCancellable>()
    
    public var isLogin = CurrentValueSubject<Bool, Never>(false)
    
    private init() {}
    
    public func configGoogleSignIn(_ googleSignInType: GoogleSignInType.Type) {
        self.googleSignInType = googleSignInType
        self.googleSignInType.config()
        
        // SubscribeIsLogin
        self.subscribeIsLogin()
    }
    
    public func signIn() {
        self.googleSignInType.signIn()
    }
    
    public func signOut() {
        self.googleSignInType.signOut()
    }
    
    private func subscribeIsLogin() {
        self.googleSignInType.isLogin.sink { (response) in
            self.isLogin.send(response)
        }
        .store(in: &self.subscriptions)
    }
}
