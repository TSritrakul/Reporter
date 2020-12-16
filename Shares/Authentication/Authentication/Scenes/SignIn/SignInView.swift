//
//  SignInView.swift
//  Authentication
//
//  Created by Thatchaphon Sritrakul on 15/12/2563 BE.
//

import SwiftUI

public struct SignInView: View {
    public init() {}
    
    public var body: some View {
        VStack {
            Button("SignIn with Google") {
                GoogleSignInManager.shared.signIn()
            }
            Button("LogOut") {
                GoogleSignInManager.shared.signOut()
            }
        }
    }
}

struct SignInView_Previews: PreviewProvider {
    static var previews: some View {
        SignInView()
    }
}
