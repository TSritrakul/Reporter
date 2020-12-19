//
//  AuthenticationScene.swift
//  Reporter
//
//  Created by Thatchaphon Sritrakul on 17/12/2563 BE.
//

import Foundation
import SwiftUI
import Combine
import Authentication
import Core

enum AuthenticationScene {
    case signInView
}

extension AuthenticationScene: SceneType {
    func view() -> AnyView {
        switch self {
        case .signInView:
            let viewModel: SignInViewModel = SignInViewModel(opener: self.opener())
            return AnyView(SignInView(viewModel: viewModel))
        }
    }
    
    func viewController() -> UIViewController {
        switch self {
        case .signInView:
            let viewModel: SignInViewModel = SignInViewModel(opener: self.opener())
            let viewController: UIViewController = UIHostingController(rootView: SignInView(viewModel: viewModel))
            return viewController
        }
    }
    
    var storyboard: UIStoryboard {
        switch self {
        case .signInView:
            return UIStoryboard()
        }
    }
    
    var identifier: String {
        switch self {
        case .signInView:
            return ""
        }
    }
}


extension AuthenticationScene {
    private func opener() -> ((AuthenticationOpener) -> Void)? {
        return { opener in
            switch opener {
            case .loginSuccess:
                let scene: SceneType = ReporterScene.tabBarView
                let transition: SceneTransitionType = .root(scene: scene)
                let coordinator: SceneCoordinator = SceneCoordinator()
                coordinator.transition(type: transition)
            }
        }
    }
}
