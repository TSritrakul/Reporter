//
//  MainView.swift
//  Reporter
//
//  Created by Thatchaphon Sritrakul on 18/12/2563 BE.
//

import SwiftUI
import Authentication

struct MainView: View {
    @ObservedObject public var viewModel: MainViewModel
    
    var body: some View {
        if self.viewModel.isLogin {
            TabBarView(viewModel: TabBarViewModel())
        } else {
            SignInViewRepresentable()
        }
    }
}

struct MainView_Previews: PreviewProvider {
    static var previews: some View {
        MainView(viewModel: MainViewModel())
    }
}

struct SignInViewRepresentable: UIViewControllerRepresentable {

    func makeUIViewController(context: UIViewControllerRepresentableContext<SignInViewRepresentable>) -> UIViewController {
        return AuthenticationScene.viewController(.signInView)()
    }

    func updateUIViewController(_ uiViewController: UIViewController, context: UIViewControllerRepresentableContext<SignInViewRepresentable>) {
    }
}
