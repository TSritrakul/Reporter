//
//  SceneCoordinator.swift
//  Core
//
//  Created by Thatchaphon Sritrakul on 18/12/2563 BE.
//

import Foundation
import Combine
import UIKit

public protocol SceneCoordinatorType {
    @discardableResult
    func transition(type: SceneTransitionType) -> Future<Void, Never>
}

public class SceneCoordinator: SceneCoordinatorType {
    
    private var topViewController: UIViewController
    private weak var window: UIWindow?
    
    public init() {
        
        let keyWindow = UIApplication.shared.windows.filter {$0.isKeyWindow}.first
        self.window = keyWindow
        if var topViewController = keyWindow?.rootViewController {
            while let presentedViewController = topViewController.presentedViewController {
                topViewController = presentedViewController
            }
            self.topViewController = topViewController
        } else {
            self.topViewController = UIViewController()
        }
    }
    
    @discardableResult
    public func transition(type: SceneTransitionType) -> Future<Void, Never> {
        return Future { [weak self] (promise) in
            guard let self = self else { return }
            switch type {
            case .root(scene: let scene):
                let viewController = scene.viewController()
                self.window?.rootViewController = viewController
                self.window?.makeKeyAndVisible()
                break
            case .modal(scene: let scene, animated: let animated):
                let viewController = scene.viewController()
                self.topViewController.present(viewController, animated: animated, completion: nil)
                break
            case .dismiss(animated: let animated):
                self.topViewController.dismiss(animated: animated, completion: nil)
                break
            }
        }
    }
}
