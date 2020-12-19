//
//  SceneTransitionType.swift
//  Core
//
//  Created by Thatchaphon Sritrakul on 18/12/2563 BE.
//

import Foundation
import UIKit

public enum SceneTransitionType {
    case root(scene: SceneType)
//    case push(scene: SceneType, animated: Bool)
//    case backToRootAndPush(scene: SceneType, animated: Bool)
    case modal(scene: SceneType, animated: Bool)
//    case modalNoNav(scene: SceneType, animated: Bool)
//    case dialog(scene: SceneType, animated: Bool, presentationStyle: UIModalPresentationStyle? = .overCurrentContext)
//    case pop(animated: Bool)
    case dismiss(animated: Bool)
//    case switchTabbar(index: Int)
}
