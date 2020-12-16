//
//  GoogleSignInType.swift
//  Authentication
//
//  Created by Thatchaphon Sritrakul on 14/12/2563 BE.
//

import Foundation

public protocol GoogleSignInType {
    static func signIn()
    static func signOut()
    static func config()
}
