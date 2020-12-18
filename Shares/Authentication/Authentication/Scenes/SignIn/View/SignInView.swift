//
//  SignInView.swift
//  Authentication
//
//  Created by Thatchaphon Sritrakul on 15/12/2563 BE.
//

import SwiftUI

public struct SignInView: View {
    
    @ObservedObject public var viewModel: SignInViewModel
    
    public init(viewModel: SignInViewModel) {
        self.viewModel = viewModel
    }
    
    public var body: some View {
        VStack {
            if self.viewModel.isLogin {
                Button("LogOut") {
                    GoogleSignInManager.shared.signOut()
                }
            } else {
                Button("SignIn with Google") {
                    GoogleSignInManager.shared.signIn()
                }
            }
        }
    }
}

//struct SignInView_Previews: PreviewProvider {
//    static var previews: some View {
//        SignInView(viewModel: SignInViewModel(opener: <#(AuthenticationOpener) -> Future<Void, Never>#>))
//    }
//}
