//
//  GoogleSignInType.swift
//  Authentication
//
//  Created by Thatchaphon Sritrakul on 14/12/2563 BE.
//

import Foundation
import Combine

public protocol GoogleSignInType {
    static func signIn()
    static func signOut()
    static func config()
    static var isLogin: PassthroughSubject<Bool, Never> { get }
}
