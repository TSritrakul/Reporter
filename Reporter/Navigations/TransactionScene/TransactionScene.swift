//
//  TransactionScene.swift
//  Reporter
//
//  Created by Thatchaphon Sritrakul on 19/12/2563 BE.
//

import Foundation
import SwiftUI
import Core
import Transaction
import Combine

enum TransactionScene {
    case transaction
    case addTransaction
}

extension TransactionScene: SceneType {
    func view() -> AnyView {
        switch self {
        case .transaction:
            let viewModel: TransactionViewModel = TransactionViewModel(opener: self.opener())
            return AnyView(TransactionView(viewModel: viewModel))
        case .addTransaction:
            let viewModel: AddTransactionViewModel = AddTransactionViewModel(opener: self.opener())
            return AnyView(AddTransactionView(viewModel: viewModel))
        }
    }
    
    func viewController() -> UIViewController {
        switch self {
        case .transaction:
            let viewModel: TransactionViewModel = TransactionViewModel(opener: self.opener())
            let viewController: UIViewController = UIHostingController(rootView: TransactionView(viewModel: viewModel))
            return viewController
        case .addTransaction:
            let viewModel: AddTransactionViewModel = AddTransactionViewModel(opener: self.opener())
            let viewController: UIViewController = UIHostingController(rootView: AddTransactionView(viewModel: viewModel))
            return viewController
        }
    }
    
    var storyboard: UIStoryboard {
        switch self {
        case .transaction:
            return UIStoryboard()
        case .addTransaction:
            return UIStoryboard()
        }
    }
    
    var identifier: String {
        switch self {
        case .transaction:
            return ""
        case .addTransaction:
            return ""
        }
    }
}

extension TransactionScene {
    private func opener() -> ((TransactionOpener) -> Void)? {
        return { opener in
            switch opener {
            case .addTransaction:
                let scene: SceneType = TransactionScene.addTransaction
                let transition: SceneTransitionType = .modal(scene: scene, animated: true)
                let coordinator: SceneCoordinator = SceneCoordinator()
                coordinator.transition(type: transition)
            case .dismiss:
                let transition: SceneTransitionType = .dismiss(animated: true)
                let coordinator: SceneCoordinator = SceneCoordinator()
                coordinator.transition(type: transition)
            }
        }
    }
}
