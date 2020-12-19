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

enum TransactionScene {
    case transaction
    case addTransaction
}

extension TransactionScene: SceneType {
    func viewController() -> UIViewController {
        switch self {
        case .transaction:
            let viewModel: TransactionViewModel = TransactionViewModel(opener: self.opener())
            let viewController: UIViewController = UIHostingController(rootView: TransactionView(viewModel: viewModel))
            return viewController
        case .addTransaction:
            let viewModel: AddTransactionViewModel = AddTransactionViewModel()
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
            }
        }
    }
}
