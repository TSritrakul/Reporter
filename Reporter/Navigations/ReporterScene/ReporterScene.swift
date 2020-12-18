//
//  ReporterScene.swift
//  Reporter
//
//  Created by Thatchaphon Sritrakul on 18/12/2563 BE.
//

import Foundation
import SwiftUI
import Core

enum ReporterScene {
    case tabBarView
}

extension ReporterScene: SceneType {
    func viewController() -> UIViewController {
        switch self {
        case .tabBarView:
            let viewModel: TabBarViewModel = TabBarViewModel()
            let viewController: UIViewController = UIHostingController(rootView: TabBarView(viewModel: viewModel))
            return viewController
        }
    }
    
    var storyboard: UIStoryboard {
        switch self {
        case .tabBarView:
            return UIStoryboard()
        }
    }
    
    var identifier: String {
        switch self {
        case .tabBarView:
            return ""
        }
    }
}
