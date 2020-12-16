//
//  GoogleSignInManager.swift
//  Authentication
//
//  Created by Thatchaphon Sritrakul on 14/12/2563 BE.
//

import Foundation

public class GoogleSignInManager {
    public static let shared: GoogleSignInManager = GoogleSignInManager()
    private var googleSignInType: GoogleSignInType.Type!
    
    private init() {}
    
    public func configGoogleSignIn(_ googleSignInType: GoogleSignInType.Type) {
        self.googleSignInType = googleSignInType
        self.googleSignInType.config()
    }
    
    public func signIn() {
        self.googleSignInType.signIn()
    }
    
    public func signOut() {
        self.googleSignInType.signOut()
    }
}
